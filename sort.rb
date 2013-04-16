#!/usr/bin/env ruby

require 'fileutils'

# Number of output images in a single folder
IMAGE_FOLDER_SIZE = 30

# Total number of images
IMAGE_SET_SIZE = Dir.glob("input/**/*.{bmp,jp2}").select { |file| File.file?(file) }.count

(IMAGE_SET_SIZE / IMAGE_FOLDER_SIZE.to_f).ceil.times do |i|
  already_taken   = []
  distortion_used = Hash.new { |hash, key| hash[key] = 0 }

  Dir.glob("input/**/*.{bmp,jp2}").each do |file|
    # next if item == '.' or item == '..'

    # Parts of filename (female_asian_11_Blur_23)
    # 0. Male/female
    # 1. Race
    # 2. Number in the set
    # 3. Type of distortion
    # 4. Level of distortion
    parts = File.basename(file).split("_")

    # Second part is number of image. Do not put the same image into a single folder
    next if already_taken.include?(parts[2])

    # Each type of distortion should be used no more than 5 times
    next if distortion_used[parts[3]] > 5

    # Skip if folder is filled already
    next if already_taken.size > IMAGE_FOLDER_SIZE

    # Create a folder
    new_path = "output/#{i}"
    FileUtils.mkpath(new_path) unless File.directory?(new_path)

    # Move file into a folder
    FileUtils.move file, new_path

    # Update arrays and hashes
    already_taken << parts[2]
    distortion_used[parts[3]] += 1
  end
end