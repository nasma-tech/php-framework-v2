<?php

namespace Packages\Quotation;

use RuntimeException;
use Throwable;

class QuotationGenerator
{
    private array $data;
    private string $templatePath;

    public function __construct(array $data, string $templateName)
    {
        $this->data = $data;

        $this->templatePath = __DIR__ . "/templates/$templateName/$templateName.php";
    }

    /**
     * Render quotation HTML
     */
    public function render(): string
    {
        if (!is_file($this->templatePath)) {
            throw new RuntimeException(
                'Quotation template not found: ' . $this->templatePath
            );
        }

        $quote = $this->data;

        $escape = static function ($value): string {
            return htmlspecialchars(
                (string)($value ?? ''),
                ENT_QUOTES | ENT_SUBSTITUTE,
                'UTF-8'
            );
        };

        ob_start();

        try {
            require $this->templatePath;

            return ob_get_clean();
        } catch (Throwable $exception) {
            ob_end_clean();
            throw $exception;
        }
    }
}