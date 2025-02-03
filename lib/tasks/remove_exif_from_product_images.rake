task remove_exif_from_product_images: :environment do
  Product.all.each do |product|
    next if product.image.nil?
    attachment = product.image.attachment
    next if attachment.nil? || attachment.content_type != "image/jpeg"
    puts "Attachment object: #{attachment}"

    mm_image = MiniMagick::Image.read(attachment.download)
    puts "Stripping image: #{mm_image}"
    mm_image.strip
    puts "Overwriting image: #{mm_image}"
    image_path = ActiveStorage::Blob.service.path_for(attachment.key)
    mm_image.write(image_path)
  end
end
