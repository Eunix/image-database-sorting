#!/usr/bin/env ruby

# Number of output images in a single folder
IMAGE_FOLDER_SIZE = 30

# Total number of images
IMAGE_SET_SIZE = Dir.glob("input/**/*.jpg").select { |file| File.file?(file) }.count

(IMAGE_SET_SIZE / IMAGE_FOLDER_SIZE.to_f).ceil.times do
  already_taken = []

  Dir.glob("input/**/*.jpg").each do |file|
    # next if item == '.' or item == '..'

    # Parts of filename:
    # 1. Male/female
    # 2. Number in the set
    # 3. Type of distortion
    # 4. Level of distortion
    parts = File.basename(file).split("_")

    # Second part is number of image. Do not put the same image into a single folder
    next if already_taken.include?(parts[1])



  end
end