def fileUpload(event, context):
    file_data = event
    bucket_name = file_data['bucket']
    file_name = file_data['name']
    file_size = file_data['size']

    print(f"File uploaded: {file_name} in bucket: {bucket_name}")
    print(f"File size: {file_size} bytes")

    return "File processing completed"