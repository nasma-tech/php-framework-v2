/* ==========================================================================
   Oil Card Loader
   ----------------------------------------------------------------------
   Usage (unchanged API):
       const loader = oilCardLoader(".my-card");   // creates + shows
       loader.hide();  loader.show();  loader.destroy();

   Optional second argument:
       oilCardLoader(".my-card", {
           title: "در حال بارگذاری",   // single short line
           theme: "auto",              // "auto" | "light" | "dark"
           duration: 20,               // seconds for one full story (8–90)
           flow: "ltr",                // "ltr" | "rtl"  (mirrors the scene)
           blockInput: true            // make the covered content inert
       });

   The whole story is ONE continuous scene driven by ONE master timeline
   (Web Animations API). Every part shares the same duration, so nothing can
   drift out of sync, and hide() pauses everything.
   ========================================================================== */
(function (global) {
    "use strict";

    const instances = new WeakMap();
    const active = new Set();          // instances currently visible
    let uidCounter = 0;

    /* ------------------------------------------------------------------ *
     *  Settings
     * ------------------------------------------------------------------ */

    const CYCLE = 20;                  // seconds: one full story
    const FROZEN_AT = 6.4;             // seconds: pose used for reduced motion
    const DEFAULT_TITLE = "در حال بارگذاری";

    const DEFAULTS = {
        title: DEFAULT_TITLE,
        theme: "auto",
        duration: CYCLE,
        flow: "ltr",
        blockInput: true
    };

    /* ------------------------------------------------------------------ *
     *  Scene geometry (world units; the camera window is 400 × 260)
     * ------------------------------------------------------------------ */

    const GROUND_Y = 210;              // top surface of conveyor / cargo floor
    const STREAM_Y = 133;              // tap nozzle tip
    const STREAM_LEN = GROUND_Y - STREAM_Y;
    const G_EMPTY_TY = 67;             // gallon liquid rect: translateY when empty
    const G_FULL_TY = 16;              // …and when full
    const SURF_END_Y = GROUND_Y - 66 + G_FULL_TY;          // 160
    const STREAM_A_END = SURF_END_Y - STREAM_Y;            // 27
    const STREAM_B_END = STREAM_A_END / STREAM_LEN;

    const B_EMPTY_TY = 59;             // barrel liquid rect (height 59)
    const B_START_TY = 50;
    const B_FULL_TY = 12;
    const B_POURED_TY = 28;

    const DROP_FALL = 18;
    const GRIP_Y = 31;                 // underside of the gripper carriage
    const PAD_H = 6;
    const CAP_TOP_Y = GROUND_Y - 72;   // 138
    const LEN_PICK = CAP_TOP_Y - PAD_H - GRIP_Y;            // 101
    const LIFT = 78;
    const LEN_LIFT = LEN_PICK - LIFT;
    const LEN_IDLE = 14;

    const TRUCK_RUN = 330;
    const WHEEL_R = 14;
    const WHEEL_DEG = (TRUCK_RUN / WHEEL_R) * (180 / Math.PI);

    const BARREL = "M126 71 Q121 100 126 130 H204 Q209 100 204 71 Z";
    const GALLON = "M-24 -9 Q-24 0 -15 0 H15 Q24 0 24 -9 V-42 Q24 -50 15 -52.5 L8.5 -55 V-65 H-8.5 V-55 L-15 -52.5 Q-24 -50 -24 -42 Z";
    const DROP = "M0 -6 C3.5 -1.5 4.6 1.2 4.6 2.6 A4.6 4.6 0 0 1 -4.6 2.6 C-4.6 1.2 -3.5 -1.5 0 -6 Z";

    /* ------------------------------------------------------------------ *
     *  Timeline (seconds)
     * ------------------------------------------------------------------ */

    const S = {
        fadeIn: [0, 0.7],
        dropFirst: 0.8,
        dropGap: 0.9,
        dropCount: 4,
        barrelRise: [1.55, 4.4],
        valveOpen: [4.5, 4.9],
        streamIn: [4.8, 5.1],
        fill: [5.1, 7.4],
        valveClose: [7.4, 7.8],
        streamOut: [7.4, 7.9],
        cap: [8.0, 8.6],
        move1: [8.8, 10.1],
        gripDown: [10.2, 10.65],
        lift: [10.8, 11.3],
        carry: [11.35, 12.05],
        lower: [12.1, 12.6],
        release: [12.7, 13.1],
        flaps: [13.0, 13.5],
        tape: [13.45, 13.8],
        pan2: [13.9, 15.6],
        convey2: [13.9, 16.4],
        door: [16.5, 17.0],
        depart: [17.2, 18.6],
        fadeOut: [18.6, 19.3]
    };

    const EASE = {
        linear: "linear",
        soft: "cubic-bezier(.45,0,.55,1)",
        inOut: "cubic-bezier(.65,0,.35,1)",
        conv: "cubic-bezier(.45,0,.4,1)",
        out: "cubic-bezier(.22,.61,.36,1)",
        in: "cubic-bezier(.55,0,.85,.35)",
        fall: "cubic-bezier(.5,0,.9,.5)"
    };

    const tr = (x, y = 0, extra) => Object.assign({ transform: `translate(${x}px, ${y}px)` }, extra);

    /** Builds WAAPI keyframes from "hold, then move" steps. */
    function timeline(initial) {
        const frames = [[0, initial, "linear"]];
        let current = initial;

        const api = {
            to(start, end, value, easing) {
                const last = frames[frames.length - 1];

                if (start < last[0] || end < start) {
                    throw new Error(`oilCardLoader timeline out of order at ${start}s`);
                }

                if (last[0] === start) {
                    last[2] = easing || EASE.soft;
                } else {
                    frames.push([start, current, easing || EASE.soft]);
                }

                frames.push([end, value, "linear"]);
                current = value;
                return api;
            },

            keyframes() {
                const out = frames.map(([t, value, easing]) =>
                    Object.assign({ offset: t / CYCLE, easing }, value));

                if (frames[frames.length - 1][0] < CYCLE) {
                    out.push(Object.assign({ offset: 1, easing: "linear" }, current));
                }

                return out;
            }
        };

        return api;
    }

    /** hook name → keyframes. Built once, shared by every instance. */
    function buildTracks() {
        const list = [];
        const add = (hook, tl) => list.push([hook, tl.keyframes()]);

        // World fade (also hides the reset between two loops)
        add("world", timeline({ opacity: 0 })
            .to(S.fadeIn[0], S.fadeIn[1], { opacity: 1 }, EASE.out)
            .to(S.fadeOut[0], S.fadeOut[1], { opacity: 0 }, EASE.soft));

        // Camera: follows the product
        add("cam", timeline(tr(0))
            .to(S.move1[0], S.move1[1], tr(-400), EASE.inOut)
            .to(S.pan2[0], S.pan2[1], tr(-800), EASE.inOut));

        // Drops from the pipe
        for (let i = 0; i < S.dropCount; i++) {
            const t0 = S.dropFirst + i * S.dropGap;
            const form = t0 + 0.35;
            const fallStart = t0 + 0.4;
            const hit = t0 + 0.75;

            add(`drop-${i}`, timeline({ transform: "translateY(0px) scale(.2, .2)", opacity: 0 })
                .to(t0, form, { transform: "translateY(0px) scale(1, 1)", opacity: 1 }, EASE.out)
                .to(fallStart, hit, { transform: `translateY(${DROP_FALL}px) scale(.88, 1.18)`, opacity: 1 }, EASE.fall)
                .to(hit, hit + 0.05, { transform: `translateY(${DROP_FALL}px) scale(.88, 1.18)`, opacity: 0 }, EASE.linear));
        }

        // Barrel: fills from the pipe, then feeds the gallon
        add("barrel-level", timeline({ transform: `translateY(${B_START_TY}px)` })
            .to(S.barrelRise[0], S.barrelRise[1], { transform: `translateY(${B_FULL_TY}px)` }, EASE.soft)
            .to(S.fill[0], S.fill[1], { transform: `translateY(${B_POURED_TY}px)` }, EASE.linear));

        // Valve lever
        add("lever", timeline({ transform: "rotate(0deg)" })
            .to(S.valveOpen[0], S.valveOpen[1], { transform: "rotate(-90deg)" }, EASE.soft)
            .to(S.valveClose[0], S.valveClose[1], { transform: "rotate(0deg)" }, EASE.soft));

        // Stream: grows, shortens as the level rises, then detaches and falls in.
        // translateY(a) + scaleY(b) keeps its bottom glued to the oil surface.
        add("stream", timeline({ transform: "translateY(0px) scaleY(0)", opacity: 0 })
            .to(S.streamIn[0], S.streamIn[1], { transform: "translateY(0px) scaleY(1)", opacity: 1 }, EASE.out)
            .to(S.fill[0], S.fill[1], { transform: `translateY(0px) scaleY(${STREAM_B_END})`, opacity: 1 }, EASE.linear)
            .to(S.streamOut[0], S.streamOut[1], { transform: `translateY(${STREAM_A_END}px) scaleY(0)`, opacity: 1 }, EASE.linear));

        // Gallon liquid
        add("gallon-level", timeline({ transform: `translateY(${G_EMPTY_TY}px)` })
            .to(S.fill[0], S.fill[1], { transform: `translateY(${G_FULL_TY}px)` }, EASE.linear));

        // Cap lands on the gallon
        add("cap", timeline(tr(32, -28, { opacity: 0 }))
            .to(S.cap[0], S.cap[1], tr(0, 0, { opacity: 1 }), EASE.out)
            .to(S.cap[1], S.cap[1] + 0.1, tr(0, 1.5, { opacity: 1 }), EASE.soft)
            .to(S.cap[1] + 0.1, S.cap[1] + 0.2, tr(0, 0, { opacity: 1 }), EASE.soft));

        // Gallon: belt → lifted → carried → lowered → rides inside the carton
        add("gallon", timeline(tr(0, 0))
            .to(S.move1[0], S.move1[1], tr(275, 0), EASE.inOut)
            .to(S.lift[0], S.lift[1], tr(275, -LIFT), EASE.inOut)
            .to(S.carry[0], S.carry[1], tr(445, -LIFT), EASE.inOut)
            .to(S.lower[0], S.lower[1], tr(445, 0), EASE.inOut)
            .to(S.convey2[0], S.convey2[1], tr(730, 0), EASE.conv));

        // Gripper: carriage + rod + suction pad (same steps, same easing as the gallon)
        add("grip", timeline(tr(0))
            .to(S.carry[0], S.carry[1], tr(170), EASE.inOut));

        const lengths = [
            [S.gripDown, LEN_PICK],
            [S.lift, LEN_LIFT],
            [S.lower, LEN_PICK],
            [S.release, LEN_IDLE]
        ];
        const rod = timeline({ transform: `scaleY(${LEN_IDLE / LEN_PICK})` });
        const pad = timeline({ transform: `translateY(${LEN_IDLE}px)` });

        lengths.forEach(([span, len]) => {
            rod.to(span[0], span[1], { transform: `scaleY(${len / LEN_PICK})` }, EASE.inOut);
            pad.to(span[0], span[1], { transform: `translateY(${len}px)` }, EASE.inOut);
        });

        add("rod", rod);
        add("pad", pad);

        // Carton: waits open, takes the gallon, closes, rides the belt to the truck
        add("carton", timeline(tr(0))
            .to(S.convey2[0], S.convey2[1], tr(285), EASE.conv));

        add("flap-l", timeline({ transform: "rotate(-132deg)" })
            .to(S.flaps[0], S.flaps[1], { transform: "rotate(0deg)" }, EASE.inOut));

        add("flap-r", timeline({ transform: "rotate(132deg)" })
            .to(S.flaps[0], S.flaps[1], { transform: "rotate(0deg)" }, EASE.inOut));

        add("tape", timeline({ transform: "scaleY(0)" })
            .to(S.tape[0], S.tape[1], { transform: "scaleY(1)" }, EASE.out));

        // Belt dots move exactly as far as the product they carry
        add("belt", timeline({ strokeDashoffset: "0px" })
            .to(S.move1[0], S.move1[1], { strokeDashoffset: "-275px" }, EASE.inOut)
            .to(S.convey2[0], S.convey2[1], { strokeDashoffset: "-560px" }, EASE.conv));

        // Truck: door closes, then leaves (wheels roll exactly the distance driven)
        add("door", timeline({ transform: "scaleY(0)" })
            .to(S.door[0], S.door[1], { transform: "scaleY(1)" }, EASE.soft));

        add("depart", timeline(tr(0))
            .to(S.depart[0], S.depart[1], tr(TRUCK_RUN), EASE.in));

        add("wheel", timeline({ transform: "rotate(0deg)" })
            .to(S.depart[0], S.depart[1], { transform: `rotate(${WHEEL_DEG}deg)` }, EASE.in));

        add("speed", timeline({ opacity: 0, transform: "scaleX(.3)" })
            .to(S.depart[0], S.depart[0] + 0.5, { opacity: 0.85, transform: "scaleX(1)" }, EASE.out)
            .to(S.depart[1] - 0.6, S.depart[1], { opacity: 0, transform: "scaleX(1)" }, EASE.soft));

        return list;
    }

    const TRACKS = buildTracks();

    /* ------------------------------------------------------------------ *
     *  Markup
     * ------------------------------------------------------------------ */

    function createMarkup(uid) {
        const drops = Array.from({ length: S.dropCount }, (_, i) => `
            <g transform="translate(165 46)"><g data-a="drop-${i}"><path d="${DROP}" fill="url(#${uid}-oil)"/></g></g>`).join("");

        return `
            <div class="oil-loader-inner">
                <div class="oil-loader-scene">
                    <svg class="oil-svg" viewBox="0 0 400 260" preserveAspectRatio="xMidYMid meet" aria-hidden="true" focusable="false">
                        <defs>
                            <linearGradient id="${uid}-oil" x1="0" y1="0" x2="0" y2="1">
                                <stop offset="0" class="oil-stop-hi"/>
                                <stop offset=".5" class="oil-stop-mid"/>
                                <stop offset="1" class="oil-stop-lo"/>
                            </linearGradient>
                            <clipPath id="${uid}-barrel"><path d="${BARREL}"/></clipPath>
                            <clipPath id="${uid}-gallon"><path d="${GALLON}"/></clipPath>
                        </defs>

                        <g data-a="world"><g data-a="cam">

                            <path class="oil-ground" d="M-120 242 H1400"/>

                            <!-- supports (behind the belt) -->
                            <g class="oil-st oil-m2">
                                <rect x="52" y="222" width="6" height="20"/>
                                <rect x="340" y="222" width="6" height="20"/>
                                <rect x="540" y="222" width="6" height="20"/>
                                <rect x="760" y="222" width="6" height="20"/>
                            </g>
                            <g class="oil-st oil-m">
                                <rect x="133" y="136" width="6" height="106"/>
                                <rect x="191" y="136" width="6" height="106"/>
                                <rect x="435" y="26" width="6" height="216"/>
                                <rect x="762" y="26" width="6" height="216"/>
                            </g>
                            <g class="oil-st oil-m2">
                                <rect x="139" y="174" width="52" height="4"/>
                                <rect x="127" y="238" width="18" height="4" rx="2"/>
                                <rect x="185" y="238" width="18" height="4" rx="2"/>
                                <rect x="429" y="238" width="18" height="4" rx="2"/>
                                <rect x="756" y="238" width="18" height="4" rx="2"/>
                                <rect x="435" y="20" width="333" height="6" rx="3"/>
                            </g>

                            <!-- inlet pipe -->
                            <path class="oil-pipe-o" d="M-60 16 H151 Q165 16 165 30 V35"/>
                            <path class="oil-pipe-i" d="M-60 16 H151 Q165 16 165 30 V35"/>
                            <g class="oil-st oil-m2">
                                <rect x="40" y="6" width="6" height="20" rx="2"/>
                                <rect x="98" y="6" width="6" height="20" rx="2"/>
                                <path d="M158 34 H172 L169.5 43 H160.5 Z"/>
                            </g>

                            ${drops}

                            <!-- barrel -->
                            <path class="oil-gl" d="${BARREL}"/>
                            <g clip-path="url(#${uid}-barrel)">
                                <rect data-a="barrel-level" x="118" y="71" width="94" height="59" fill="url(#${uid}-oil)"/>
                                <path class="oil-hoop" d="M118 85 Q165 92 212 85 M118 117 Q165 124 212 117"/>
                            </g>
                            <rect class="oil-hi" x="131" y="77" width="3.4" height="46" rx="1.7"/>
                            <path class="oil-st oil-nf" d="${BARREL}"/>
                            <rect class="oil-st oil-m2" x="119" y="64" width="92" height="7" rx="3.5"/>
                            <rect class="oil-slot" x="150" y="65.3" width="30" height="3.4" rx="1.7"/>
                            <rect class="oil-st oil-m2" x="121" y="130" width="88" height="6" rx="3"/>

                            <!-- tap -->
                            <path class="oil-pipe-o" d="M205 118 H238 Q245 118 245 125 V128"/>
                            <path class="oil-pipe-i" d="M205 118 H238 Q245 118 245 125 V128"/>
                            <rect class="oil-st oil-m2" x="203" y="112" width="5" height="12" rx="1.5"/>
                            <rect class="oil-st oil-m2" x="221" y="111" width="14" height="14" rx="3"/>
                            <path class="oil-st oil-m2" d="M240.5 127 H249.5 L248 133 H242 Z"/>
                            <g transform="translate(228 111)"><g data-a="lever">
                                <path class="oil-lever" d="M0 0 V-13"/>
                                <circle class="oil-st oil-gold" cx="0" cy="-14.5" r="3.2"/>
                            </g></g>

                            <!-- conveyor -->
                            <rect class="oil-st oil-m2" x="-60" y="210" width="950" height="12" rx="3"/>
                            <path class="oil-gstk" d="M-56 211.4 H886" opacity=".7"/>
                            <path data-a="belt" class="oil-ticks" d="M-52 216.6 H882"/>

                            <!-- everything that leaves with the truck -->
                            <g data-a="depart">
                                <rect class="oil-cargo" x="896" y="119" width="144" height="91"/>
                                <path class="oil-floor" d="M896 210 H1040"/>

                                <g transform="translate(690 210)"><g data-a="carton">
                                    <rect class="oil-st oil-cart2" x="-36" y="-78" width="72" height="78"/>
                                </g></g>

                                <g transform="translate(245 210)"><g data-a="gallon">
                                    <path class="oil-st oil-nf" stroke-width="3.2" d="M24 -46 Q33 -46 33 -37 V-25 Q33 -16 24 -16"/>
                                    <path class="oil-gl2" d="${GALLON}"/>
                                    <g clip-path="url(#${uid}-gallon)">
                                        <rect data-a="gallon-level" x="-26" y="-66" width="52" height="67" fill="url(#${uid}-oil)"/>
                                    </g>
                                    <rect class="oil-label" x="-18" y="-40" width="36" height="22" rx="3"/>
                                    <g transform="translate(0 -28.5) scale(.78)"><path class="oil-gold" d="${DROP}"/></g>
                                    <rect class="oil-hi" x="-20" y="-48" width="3" height="34" rx="1.5"/>
                                    <path class="oil-st oil-nf" d="${GALLON}"/>
                                    <g data-a="cap" opacity="0">
                                        <rect class="oil-st oil-gold" x="-10" y="-72" width="20" height="7" rx="2.5"/>
                                        <path class="oil-cap-ridge" d="M-4 -70.5 V-66.5 M0 -70.5 V-66.5 M4 -70.5 V-66.5"/>
                                    </g>
                                </g></g>

                                <g transform="translate(690 210)"><g data-a="carton">
                                    <rect class="oil-st oil-cart" x="-38" y="-64" width="76" height="64" rx="1.5"/>
                                    <g transform="translate(0 -26)">
                                        <circle class="oil-gstk" r="10"/>
                                        <g transform="translate(0 1) scale(.85)"><path class="oil-gold" d="${DROP}"/></g>
                                    </g>
                                    <g transform="translate(-38 -78)"><g data-a="flap-l">
                                        <rect class="oil-st oil-cart" x="0" y="0" width="38" height="14" rx="1"/>
                                    </g></g>
                                    <g transform="translate(38 -78)"><g data-a="flap-r">
                                        <rect class="oil-st oil-cart" x="-38" y="0" width="38" height="14" rx="1"/>
                                    </g></g>
                                    <rect data-a="tape" class="oil-tape" x="-6" y="-78" width="12" height="38"/>
                                </g></g>

                                <!-- truck -->
                                <g data-a="speed">
                                    <path class="oil-speed" d="M868 150 H884 M858 172 H884 M866 194 H884"/>
                                </g>
                                <path class="oil-st oil-nf" stroke-width="2.4" d="M892 216 H1042 V116 H892"/>
                                <g data-a="door">
                                    <rect class="oil-st oil-m" x="889" y="116" width="7" height="94"/>
                                    <path class="oil-st oil-nf" stroke-width="1" d="M889 140 H896 M889 164 H896 M889 188 H896"/>
                                </g>
                                <rect class="oil-st oil-m2" x="888" y="216" width="228" height="8" rx="2"/>
                                <rect class="oil-st oil-m2" x="1042" y="198" width="4" height="14"/>
                                <path class="oil-st oil-m" d="M1046 216 V160 Q1046 152 1054 152 H1078 Q1086 152 1090 158 L1110 188 V216 Z"/>
                                <path class="oil-st oil-win" stroke-width="1.2" d="M1055 162 H1077 Q1081 162 1084 166 L1097 187 H1055 Z"/>
                                <path class="oil-gstk" d="M1046 206 H1110"/>
                                <rect class="oil-gold" x="1104" y="195" width="6" height="6" rx="2"/>
                                <rect class="oil-st oil-m2" x="1106" y="208" width="10" height="8" rx="2"/>
                                <path class="oil-st oil-nf" d="M913.5 228 A16.5 16.5 0 0 1 946.5 228 M1061.5 228 A16.5 16.5 0 0 1 1094.5 228"/>
                                <g transform="translate(930 228)"><g data-a="wheel">
                                    <circle class="oil-tire" r="${WHEEL_R}"/>
                                    <circle class="oil-st oil-m" r="7"/>
                                    <path class="oil-gstk" d="M0 -5 V5 M-5 0 H5 M-3.5 -3.5 L3.5 3.5 M3.5 -3.5 L-3.5 3.5"/>
                                </g></g>
                                <g transform="translate(1078 228)"><g data-a="wheel">
                                    <circle class="oil-tire" r="${WHEEL_R}"/>
                                    <circle class="oil-st oil-m" r="7"/>
                                    <path class="oil-gstk" d="M0 -5 V5 M-5 0 H5 M-3.5 -3.5 L3.5 3.5 M3.5 -3.5 L-3.5 3.5"/>
                                </g></g>
                            </g>

                            <!-- oil stream (in front of the gallon) -->
                            <rect data-a="stream" x="243.5" y="${STREAM_Y}" width="3" height="${STREAM_LEN}" rx="1.5" fill="url(#${uid}-oil)" opacity="0"/>

                            <!-- gripper -->
                            <g transform="translate(520 0)"><g data-a="grip">
                                <rect data-a="rod" class="oil-rod" x="-1.6" y="${GRIP_Y}" width="3.2" height="${LEN_PICK}"/>
                                <rect class="oil-st oil-m2" x="-15" y="15" width="30" height="16" rx="4"/>
                                <path class="oil-gstk" d="M-8 23 H8"/>
                                <g transform="translate(0 ${GRIP_Y})"><g data-a="pad">
                                    <path class="oil-st oil-gold" d="M-3.5 0 H3.5 L7.5 4 V${PAD_H} H-7.5 V4 Z"/>
                                </g></g>
                            </g></g>

                        </g></g>
                    </svg>
                </div>
                <div class="oil-loader-title" dir="auto"></div>
            </div>
        `;
    }

    /* ------------------------------------------------------------------ *
     *  Theme detection (explicit page theme first, then OS preference)
     * ------------------------------------------------------------------ */

    const THEME_ATTRS = ["data-oil-theme", "data-bs-theme", "data-theme", "data-color-scheme", "data-color-mode", "data-mode", "theme"];
    const DARK_CLASS = /^(dark|dark-mode|dark-theme|theme-dark|night|night-mode|is-dark)$/i;
    const LIGHT_CLASS = /^(light|light-mode|light-theme|theme-light|is-light)$/i;

    const darkQuery = global.matchMedia ? global.matchMedia("(prefers-color-scheme: dark)") : null;
    const motionQuery = global.matchMedia ? global.matchMedia("(prefers-reduced-motion: reduce)") : null;

    function explicitTheme(node) {
        for (const attr of THEME_ATTRS) {
            const value = (node.getAttribute(attr) || "").toLowerCase();
            if (value.includes("dark")) return "dark";
            if (value.includes("light")) return "light";
        }

        for (const name of node.classList) {
            if (DARK_CLASS.test(name)) return "dark";
            if (LIGHT_CLASS.test(name)) return "light";
        }

        return null;
    }

    function detectTheme(element) {
        for (let node = element; node && node.nodeType === 1; node = node.parentElement) {
            const found = explicitTheme(node);
            if (found) return found;
        }

        const scheme = (getComputedStyle(document.documentElement).colorScheme || "").toLowerCase();
        if (scheme.includes("dark") && !scheme.includes("light")) return "dark";
        if (scheme.includes("light") && !scheme.includes("dark")) return "light";

        return darkQuery && darkQuery.matches ? "dark" : "light";
    }

    function listen(query, handler) {
        if (!query) return;
        if (query.addEventListener) query.addEventListener("change", handler);
        else if (query.addListener) query.addListener(handler);
    }

    let observer = null;
    let refreshQueued = false;

    function refreshActive() {
        if (refreshQueued) return;
        refreshQueued = true;

        requestAnimationFrame(() => {
            refreshQueued = false;
            active.forEach(item => item.refresh());
        });
    }

    function trackActive(instance, on) {
        if (on) active.add(instance);
        else active.delete(instance);

        if (active.size && !observer && global.MutationObserver) {
            observer = new MutationObserver(refreshActive);
            [document.documentElement, document.body].forEach(node => {
                if (node) observer.observe(node, { attributes: true, attributeFilter: ["class", ...THEME_ATTRS] });
            });
        } else if (!active.size && observer) {
            observer.disconnect();
            observer = null;
        }
    }

    listen(darkQuery, refreshActive);
    listen(motionQuery, refreshActive);

    /* ------------------------------------------------------------------ *
     *  Instance
     * ------------------------------------------------------------------ */

    function createInstance(element, options) {
        const isBody = element === document.body;
        const host = isBody ? document.body : element;
        const uid = `oil${++uidCounter}`;
        const settings = Object.assign({}, DEFAULTS);

        const originalPosition = element.style.position;
        let positionPatched = false;

        if (!isBody && getComputedStyle(element).position === "static") {
            element.style.position = "relative";
            positionPatched = true;
        }

        const overlay = document.createElement("div");
        overlay.className = `oil-card-loader oil-loader-hidden ${isBody ? "oil-loader-fullscreen" : "oil-loader-local"}`;
        overlay.setAttribute("role", "status");
        overlay.setAttribute("aria-live", "polite");
        overlay.setAttribute("aria-hidden", "true");
        overlay.innerHTML = createMarkup(uid);
        host.appendChild(overlay);

        const titleEl = overlay.querySelector(".oil-loader-title");

        let anims = null;
        let visible = false;
        let destroyed = false;
        let reducedApplied = null;
        let blocked = [];
        let previousBusy = null;

        function syncTheme() {
            const theme = settings.theme === "auto" ? detectTheme(element) : settings.theme;
            overlay.setAttribute("data-oil-theme", theme);
        }

        function ensureAnimations() {
            if (anims) return anims;
            anims = [];

            if (typeof overlay.animate !== "function") return anims;

            TRACKS.forEach(([hook, keyframes]) => {
                overlay.querySelectorAll(`[data-a="${hook}"]`).forEach(node => {
                    const animation = node.animate(keyframes, {
                        duration: settings.duration * 1000,
                        iterations: Infinity,
                        fill: "both"
                    });

                    animation.pause();
                    anims.push(animation);
                });
            });

            return anims;
        }

        function play() {
            const list = ensureAnimations();
            const reduced = !!(motionQuery && motionQuery.matches);
            reducedApplied = reduced;

            overlay.classList.toggle("oil-motion-reduced", reduced);

            list.forEach(animation => {
                if (reduced) {
                    animation.pause();
                    animation.currentTime = FROZEN_AT * (settings.duration / CYCLE) * 1000;
                } else {
                    animation.currentTime = 0;
                    animation.play();
                }
            });
        }

        function pause() {
            if (anims) anims.forEach(animation => animation.pause());
        }

        function block() {
            unblock();
            if (!settings.blockInput) return;

            blocked = [...host.children].filter(node =>
                node !== overlay &&
                !node.classList.contains("oil-card-loader") &&
                !node.hasAttribute("inert") &&
                node.tagName !== "SCRIPT" &&
                node.tagName !== "STYLE");

            blocked.forEach(node => node.setAttribute("inert", ""));
        }

        function unblock() {
            blocked.forEach(node => node.removeAttribute("inert"));
            blocked = [];
        }

        function refresh() {
            if (destroyed) return;
            syncTheme();

            const reduced = !!(motionQuery && motionQuery.matches);
            if (visible && reduced !== reducedApplied) play();
        }

        function configure(next) {
            if (destroyed || !next || typeof next !== "object") return;

            if (typeof next.title === "string") settings.title = next.title.trim() || DEFAULT_TITLE;
            if (["auto", "light", "dark"].includes(next.theme)) settings.theme = next.theme;
            if (["ltr", "rtl"].includes(next.flow)) settings.flow = next.flow;
            if (typeof next.blockInput === "boolean") settings.blockInput = next.blockInput;

            if (Number.isFinite(next.duration)) {
                settings.duration = Math.min(90, Math.max(8, next.duration));

                if (anims) {
                    anims.forEach(animation => animation.effect.updateTiming({ duration: settings.duration * 1000 }));
                    if (visible) play();
                }
            }

            titleEl.textContent = settings.title;
            overlay.classList.toggle("oil-flow-rtl", settings.flow === "rtl");
            syncTheme();

            if (visible) block();
        }

        function show() {
            if (destroyed || visible) return;
            visible = true;

            syncTheme();
            overlay.classList.remove("oil-loader-hidden");
            overlay.removeAttribute("aria-hidden");

            previousBusy = host.getAttribute("aria-busy");
            host.setAttribute("aria-busy", "true");

            block();
            play();
            trackActive(instance, true);
        }

        function hide() {
            if (destroyed || !visible) return;
            visible = false;

            overlay.classList.add("oil-loader-hidden");
            overlay.setAttribute("aria-hidden", "true");

            if (previousBusy === null) host.removeAttribute("aria-busy");
            else host.setAttribute("aria-busy", previousBusy);

            unblock();
            pause();
            trackActive(instance, false);
        }

        function destroy() {
            if (destroyed) return;

            hide();
            destroyed = true;

            if (anims) anims.forEach(animation => animation.cancel());
            anims = null;
            overlay.remove();

            if (positionPatched) element.style.position = originalPosition;

            instances.delete(element);
        }

        const instance = { element, overlay, show, hide, destroy, configure, refresh };

        configure(options || {});
        return instance;
    }

    /* ------------------------------------------------------------------ *
     *  Public API
     * ------------------------------------------------------------------ */

    function oilCardLoader(selector, options) {
        if (typeof selector !== "string" || !selector.trim()) {
            throw new Error("یک شناسه یا کلاس معتبر وارد کنید.");
        }

        let elements;

        try {
            elements = [...document.querySelectorAll(selector)];
        } catch (error) {
            throw new Error("شناسه یا کلاس واردشده معتبر نیست.");
        }

        if (!elements.length) {
            console.warn("عنصر موردنظر برای نمایش لودر پیدا نشد:", selector);
        }

        const controllers = elements.map(element => {
            let instance = instances.get(element);

            if (!instance) {
                instance = createInstance(element, options);
                instances.set(element, instance);
            } else if (options) {
                instance.configure(options);
            }

            instance.show();
            return instance;
        });

        return {
            show() {
                controllers.forEach(item => item.show());
                return this;
            },

            hide() {
                controllers.forEach(item => item.hide());
                return this;
            },

            destroy() {
                controllers.forEach(item => item.destroy());
                return this;
            },

            configure(next) {
                controllers.forEach(item => item.configure(next));
                return this;
            }
        };
    }

    global.oilCardLoader = oilCardLoader;

})(window);
