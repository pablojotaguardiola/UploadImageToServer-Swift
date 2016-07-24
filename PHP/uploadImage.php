<?php
if (move_uploaded_file($_FILES['file']['tmp_name'], "image.png")) {
    echo "File uploaded: ".$_FILES["file"]["name"];	
}
?>