class Mp3Handler < Struct.new(:listener)
  def upload mp3_upload, user
    mp3 = user.mp3_uploads.build mp3_upload

    begin
      if mp3.save
        listener.operation_succeeded_with "The file #{mp3.mp3_file_name} has been uploaded to your CloudPlayer"
      else
        raise "Error saving file #{mp3.mp3_file_name}"
      end
    rescue
      listener.operation_failed_with "The file #{mp3.mp3_file_name} couldn't have been uploaded"
    end
  end

  def delete mp3_upload_id
    mp3 = Mp3Upload.find mp3_upload_id

    begin
      if mp3.delete
        listener.operation_succeeded_with "The file #{mp3.mp3_file_name} has been deleted"
      else
        raise "Error deleting file #{mp3.mp3_file_name}"
      end
    rescue
      listener.operation_failed_with "The file #{mp3.mp3_file_name} could not be deleted. Please, try again later"
    end
  end

  def mp3_uploads_for user
    user.try :mp3_uploads
  end

  def new_mp3_upload
    Mp3Upload.new
  end
end
