<?php
function uploadImage(array $file, string $subfolder): string {
    if ($file['error'] !== UPLOAD_ERR_OK) throw new Exception('Upload failed: ' . $file['error']);
    if ($file['size'] > MAX_UPLOAD_BYTES) throw new Exception('File too large (Max 5MB)');

    // Verify MIME type
    $finfo    = new finfo(FILEINFO_MIME_TYPE);
    $mime     = $finfo->file($file['tmp_name']);
    $allowed  = [
        'image/jpeg' => 'jpg', 
        'image/png'  => 'png', 
        'image/webp' => 'webp'
    ];
    
    if (!isset($allowed[$mime])) throw new Exception('Invalid file type. Only JPG, PNG, and WEBP allowed.');

    $ext      = $allowed[$mime];
    $filename = uniqid('img_', true) . '.' . $ext;
    $dir      = UPLOAD_PATH . DIRECTORY_SEPARATOR . $subfolder;
    
    if (!is_dir($dir)) mkdir($dir, 0755, true);
    if (!move_uploaded_file($file['tmp_name'], $dir . DIRECTORY_SEPARATOR . $filename))
        throw new Exception('Could not save file to disk');

    return UPLOAD_URL . '/' . $subfolder . '/' . $filename;
}