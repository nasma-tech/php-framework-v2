<?php

namespace Packages\Support\Text;

use DOMDocument;
use DOMXPath;

class TextNormalizer
{
    public function cleanEditorHtml(?string $html): string
    {
        if (empty($html)) {
            return '';
        }

        $dom = new DOMDocument('1.0', 'UTF-8');

        libxml_use_internal_errors(true);

        $dom->loadHTML(
            '<?xml encoding="UTF-8" ?>' . $html,
            LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD
        );

        foreach ($dom->childNodes as $node) {
            if ($node->nodeType === XML_PI_NODE) {
                $dom->removeChild($node);
            }
        }

        libxml_clear_errors();

        $xpath = new DOMXPath($dom);

        // Remove unwanted attributes
        foreach ($xpath->query('//*[@style or @class]') as $element) {
            $element->removeAttribute('style');
            $element->removeAttribute('class');
        }

        // Remove empty line breaks and editor artifacts
        foreach ($xpath->query('//br') as $element) {
            $element->parentNode?->removeChild($element);
        }

        // Remove style and script tags
        foreach ($xpath->query('//style | //script') as $element) {
            $element->parentNode?->removeChild($element);
        }

        return $dom->saveHTML() ?: '';
    }

    public function removeStyleTags(?string $string): string
    {
        return preg_replace('/<style\b[^>]*>[\s\S]*?<\/style\s*>/i', '', $string) ?? '';
    }
}