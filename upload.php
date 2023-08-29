<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve form data
    $videoLink = $_POST['video_link'];
    $videoTitle = $_POST['video_title'];
    $videoDescription = $_POST['video_description'];

    // Execute bash script with collected data as arguments
    $command = '/home/grnqrtr/.youtube-upload/fb2yt.sh ' .
               escapeshellarg($videoLink) . ' ' .
               escapeshellarg($videoTitle) . ' ' .
               escapeshellarg($videoDescription);
    exec($command, $output, $returnStatus);

    if ($returnStatus === 0) {
        echo 'Video uploaded successfully!';
    } else {
        echo 'An error occurred while uploading the video.';
    }
}
?>
