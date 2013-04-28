#!/usr/bin/env ruby

require 'fileutils'

# Number of output images in a single folder
IMAGE_FOLDER_SIZE = 30

# Total number of images
IMAGE_SET_SIZE = Dir.glob("input/**/*.{bmp,jp2}").select { |file| File.file?(file) }.count

# Total number of folder
FOLDERS_NUMBER = 100

# Empty Folder
FileUtils.rm_rf('output')

# Globally already taken
file_used = Hash.new { |hash, key| hash[key] = 0 }

FOLDERS_NUMBER.times do |i|
  already_taken_in_folder     = []
  distortion_used_in_folder = Hash.new { |hash, key| hash[key] = 0 }

  Dir.glob("input/**/*.{bmp,jp2}").shuffle.each do |file|
    # next if item == '.' or item == '..'

    # Parts of filename (female_asian_11_Blur_23)
    # 0. Male/female
    # 1. Race
    # 2. Number in the set
    # 3. Type of distortion
    # 4. Level of distortion
    parts = File.basename(file).split("_")

    # Third first parts are unique for image
    image_name = parts[0..2].join("")

    # Do not put the same image into a single folder
    next if already_taken_in_folder.include?(image_name)

    # Do not use each file several times
    next if file_used[File.basename(file)] >= 4

    # Each type of distortion should be used no more than five times (five levels)
    next if distortion_used_in_folder[parts[3]] >= 5

    # Skip if folder is filled already
    next if already_taken_in_folder.size > IMAGE_FOLDER_SIZE

    # Create a folder
    new_path = "output/#{i}"
    FileUtils.mkpath(new_path) unless File.directory?(new_path)

    # Move file into a folder
    FileUtils.copy file, new_path

    # Update arrays and hashes
    already_taken_in_folder << image_name
    file_used[File.basename(file)] += 1
    distortion_used_in_folder[parts[3]] += 1
  end
end