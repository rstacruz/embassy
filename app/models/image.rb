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

  # ----------------------------------------------------------------------------

  def validate
    errors.add :project, 'is required'  if new? && !self.project
  end

  def after_save
    project = self.project and begin
      project.save

      if self.projects.map(&:id) != [project.id]
        remove_all_projects
        add_project self.project
      end
    end
  end
end
