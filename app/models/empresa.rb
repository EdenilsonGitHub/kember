class Empresa < ActiveRecord::Base
    self.table_name = 'empresas'

    include Paperclip::Glue

    validates :nome, :nome_fantasia, :sigla, :cnpj, :email, presence: true
    validates :email, :cnpj, :nome, uniqueness: true    
    validates :cnpj, length: { minimum: 14, message: 'é muito curto (mínimo: 14 caracteres)' }
    validates :cnpj, length: { maximum: 18, message: 'é muito longo (máximo: 18 caracteres)' }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    
    has_attached_file :logo, styles: { normal: "300x300>" }
    validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

    has_many :projetos
    has_many :status
    has_many :usuario_empresas
    has_many :funcionalidades
    has_many :perfils

end 