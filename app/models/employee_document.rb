class EmployeeDocument < ApplicationRecord
  belongs_to :employee

  has_attached_file :file,
    path: ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename",
    url:  "/system/:class/:attachment/:id_partition/:style/:filename"

  validates_attachment_presence :file
  validates_attachment_size :file, less_than: 10.megabytes
  validates_attachment_content_type :file, content_type: [
    "application/pdf",
    "image/jpeg",
    "image/png"
  ]

  validates :document_type, presence: true
end