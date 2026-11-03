<?php

namespace Packages\Helpers;

class FileHelper
{
    public function fileUpload(
        string $fileDirection,
        string $fileName,
        string $fileDirectionChild = ''
    ): ?string
    {
        $makeParentDirection = __SOURCE__ . 'Storage/' . trim($fileDirection, '/');

        if (!is_dir($makeParentDirection)) {
            if (!mkdir($makeParentDirection, 0777, true) && !is_dir($makeParentDirection)) {
                throw new RuntimeException(
                    'Unable to create directory: ' . $makeParentDirection
                );
            }
        }

        $targetDirectory = $makeParentDirection;

        if ($fileDirectionChild) {
            $makeChild = $makeParentDirection . '/' . trim($fileDirectionChild, '/');

            if (!is_dir($makeChild)) {
                if (!mkdir($makeChild, 0777, true) && !is_dir($makeChild)) {
                    throw new RuntimeException(
                        'Unable to create directory: ' . $makeChild
                    );
                }
            }

            $targetDirectory = $makeChild;
        }

        if (empty($_FILES[$fileName]['name'])) {
            return null;
        }

        $tmpName = $_FILES[$fileName]['tmp_name'];
        $extension = pathinfo(
            $_FILES[$fileName]['name'],
            PATHINFO_EXTENSION
        );

        $hashedFileName = md5($tmpName);

        $uploadedFileName = $hashedFileName . (
            $extension !== '' ? '.' . $extension : ''
            );

        $targetFile = $targetDirectory . '/' . $uploadedFileName;

        if (!move_uploaded_file($tmpName, $targetFile)) {
            throw new RuntimeException(
                'Unable to move uploaded file to: ' . $targetFile
            );
        }

        return $uploadedFileName;
    }


    public function normalizeUploadedFiles(string $inputName): array
    {
        if (!isset($_FILES[$inputName])) {
            return [];
        }

        $uploadedFiles = $_FILES[$inputName];

        if (!is_array($uploadedFiles['name'])) {
            return [$uploadedFiles];
        }

        $files = [];

        foreach ($uploadedFiles['name'] as $index => $name) {
            $files[$index] = [
                'name' => $name,
                'type' => $uploadedFiles['type'][$index],
                'tmp_name' => $uploadedFiles['tmp_name'][$index],
                'error' => $uploadedFiles['error'][$index],
                'size' => $uploadedFiles['size'][$index],
            ];
        }

        return $files;
    }

    public function uploadMultipleFiles(
        string $directory,
        array  $files,
        string $subdirectory = ''
    ): array
    {
        $uploadedFiles = [];

        $storageRoot = rtrim(__SOURCE__, '/\\') . '/Storage';
        $relativePath = trim($directory, '/\\');

        if ($subdirectory !== '') {
            $relativePath .= '/' . trim($subdirectory, '/\\');
        }

        // Prevent directory traversal and absolute paths.
        $pathSegments = preg_split('~[/\\\\]+~', $relativePath);

        if (
            !$pathSegments ||
            preg_match('/^[A-Za-z]:/', $relativePath) ||
            str_contains($relativePath, "\0") ||
            in_array('..', $pathSegments, true)
        ) {
            throw new InvalidArgumentException('Invalid upload directory.');
        }

        $uploadDirectory = $storageRoot . '/' . $relativePath;

        if (
            !is_dir($uploadDirectory) &&
            !mkdir($uploadDirectory, 0755, true) &&
            !is_dir($uploadDirectory)
        ) {
            throw new RuntimeException('Failed to create upload directory.');
        }

        foreach ($files as $key => $file) {
            $error = $file['error'] ?? UPLOAD_ERR_NO_FILE;

            if ($error === UPLOAD_ERR_NO_FILE) {
                continue;
            }

            if ($error !== UPLOAD_ERR_OK) {
                throw new RuntimeException("File upload error: {$error}");
            }

            if (
                ($file['size'] ?? 0) <= 0 ||
                !isset($file['tmp_name']) ||
                !is_uploaded_file($file['tmp_name'])
            ) {
                continue;
            }

            $extension = strtolower(
                pathinfo($file['name'] ?? '', PATHINFO_EXTENSION)
            );

            $filename = bin2hex(random_bytes(16));

            if ($extension !== '') {
                $filename .= '.' . $extension;
            }

            $destination = $uploadDirectory . '/' . $filename;

            if (!move_uploaded_file($file['tmp_name'], $destination)) {
                throw new RuntimeException(
                    "Failed to upload file: {$file['name']}"
                );
            }

            $uploadedFiles[$key] = [
                'name' => $filename,
                'size' => $file['size'],
            ];
        }

        return $uploadedFiles;
    }

}