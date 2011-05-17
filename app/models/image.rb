# == Usage
#
#   Image.new image_file: { tempfile: File.open('/path/to/image.jpg') }
#   Image.new image_file: File.open('/path/to/image.jpg')
#   Image.new image_file: '/path/to/image.jpg'
#
class Image < Sequel::Model
  def image
    Imagery.new :images, id,
      thumb: ["100x62^",  "100x62"],
      small: ["250x156^", "250x156"],
      large: ["900x9000>"]
  end

  def large_url
    url :large
  end

  def small_url
    url :small
  end

  def thumb_url
    url :thumb
  end

  def url(*a)
    image.url(*a)
  end

  def profile=(v)
    self.profile_id = v.id
  end

  def profile
    Profile[self.profile_id]
  end

  def project=(v)
    self.project_id = v.id
  end

  def project
    Project[self.project_id]
  end

  def image_file=(fp)
    fp = fp[:tempfile]  if fp.is_a?(Hash) && fp[:tempfile]
    fp = File.open(fp)  if fp.is_a?(String)

    @image_file = fp
  end

  # ----------------------------------------------------------------------------

  def validate
    errors.add :project, 'is required'  if new? && !self.project
    errors.add :image_file, 'is required'  unless @image_file
  end

  def after_save
    image.save(@image_file)  if @image_file
  end
end
