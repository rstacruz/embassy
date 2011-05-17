# == Usage
#
#   Image.new image_file: { tempfile: File.open('/path/to/image.jpg') }
#   Image.new image_file: File.open('/path/to/image.jpg')
#   Image.new image_file: '/path/to/image.jpg'
#
class Image < Sequel::Model
  many_to_many :projects
  many_to_many :profiles

  def project=(v)
    self.project_id = v.id
  end

  def project_id=(v)
    @project = nil
    @project_id = v
  end

  def project_id
    @project_id
  end

  def project
    @project ||= Project[@project_id] || self.projects.first
  end

  def image
    Imagery.new :images, id,
      thumb: ["100x62^",  "100x62"],
      small: ["250x156^", "250x156"],
      large: ["900x", "900x"]
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

    project = self.project and begin
      project.save

      if self.projects.map(&:id) != [project.id]
        remove_all_projects
        add_project self.project
      end
    end
  end

  def before_destroy
    remove_all_projects
  end
end
