$(function () {

    $("#parent_id").on('input', function () {
        let $element = $(this)
        let selectedOption = $element.find('option:selected')
        let $parentUnitRatio = $("#parent_unit_ratio")
        let $parentUnitRatioElement = $("#parent_unit_ratio_element")
        let $parentUnitRatioLabel = $("#parent_unit_ratio_label")

        if ($element.val()) {
            $parentUnitRatio.val("")
                .prop('required', true)
            $parentUnitRatioElement.show()
            $parentUnitRatioLabel.html(selectedOption.data('unit-label'))
        } else {
            $parentUnitRatio.val("")
                .prop('required', false)
            $parentUnitRatioElement.hide()
            $parentUnitRatioLabel.html('')
        }
    })
    $("#cost_price").priceInput()
    $("#sale_price").priceInput()
    $("#customer_price").priceInput()
    $('#parent_unit_ratio').numberInputAndDecimal()

    tinyEditor("#description")
    tinyEditor("#complete_description")

    //gallery

    const $form = $('#mainForm');
    const $imageInput = $('#imageInput');
    const $gallery = $('#imageGallery');
    const $removeButton = $('#removeCurrentImage');

    if (!$form.length || !$imageInput.length || !$gallery.length || !$removeButton.length) {
        console.error('عناصر گالری پیدا نشدند.');
        return;
    }

    const images = [];

    const splide = new Splide($gallery[0], {
        type: 'slide',
        perPage: 3,
        perMove: 1,
        arrows: true,
        pagination: true,
        drag: true,
        gap: '1rem',
        direction: 'rtl',
        breakpoints: {
            768: {perPage: 2},
            480: {perPage: 1}
        }
    });

    const updateRemoveButton = () => {
        $removeButton.prop('disabled', images.length === 0);
    };

    $('#addImageButton').on('click', function () {
        $imageInput.trigger('click');
    });

    $imageInput.on('change', function () {
        const files = Array.from(this.files);

        $.each(files, function (_, file) {
            if (!file.type.startsWith('image/')) return;

            const url = URL.createObjectURL(file);

            const $slide = $('<li>', {
                class: 'splide__slide'
            });

            const $container = $('<div>', {
                class: 'border rounded p-2'
            });

            const $preview = $('<img>', {
                src: url,
                alt: file.name
            }).css({
                display: 'block',
                width: '100%',
                height: '200px',
                objectFit: 'contain'
            });

            const $name = $('<div>', {
                class: 'text-center mt-2 text-truncate',
                text: file.name
            });

            $container.append($preview, $name);
            $slide.append($container);

            images.push({file, url});
            splide.add($slide[0]);
        });

        $(this).val('');

        updateRemoveButton();

        if (images.length) {
            splide.go(images.length - 1);
        }
    });

    $removeButton.on('click', function () {
        const index = splide.index;

        if (index < 0 || index >= images.length) return;

        const [image] = images.splice(index, 1);

        splide.remove(index);
        URL.revokeObjectURL(image.url);

        updateRemoveButton();

        if (images.length) {
            splide.go(Math.min(index, images.length - 1));
        }
    });

    $form.on('submit', function () {
        const dataTransfer = new DataTransfer();

        $.each(images, function (_, image) {
            dataTransfer.items.add(image.file);
        });

        $imageInput[0].files = dataTransfer.files;
    });

    splide.mount();
    updateRemoveButton();
});