class Image < Sequel::Model
  many_to_many :projects
  many_to_many :profiles

  def project=(v)
    self.project_id = v.id
  end

  def project_id=(v)
    @project_id = v
  end

  def project_id
    @project_id ||= projects.first && projects.first.id  unless new?
    @project_id
  end

  def project
    @project ||= if new?
      Project[project_id]
    else
      projects.first && projects.first.id
    end
  end

  def validate
    errors.add :project, 'is required'  if new? && !@project_id
  end

  def after_save
    self.project.save
  end
end
