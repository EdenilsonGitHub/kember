# encoding: UTF-8
# require 'digest'
class Usuario < ActiveRecord::Base
    self.table_name = 'usuarios'

    include Paperclip::Glue

    before_save :criptografa_senha

    validates :nome, :login, :email, :senha, :senha_confirmation, presence: true
    validates :email, :login, uniqueness: true
    validates :senha, :senha_confirmation, length: { minimum: 6, message: 'é muito curto (mínimo: 6 caracteres)' }
    validates :senha, confirmation: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :nome, length: { maximum: 45, message: 'é muito longo (máximo: 45 caracteres)' }
    validates :login, length: { maximum: 30, message: 'é muito longo (máximo: 13 caracteres)' }

    has_attached_file :logo, styles: { normal: "300x300>" }
    validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

    private

    def criptografa_senha
        self.senha = Digest::SHA256.hexdigest self.senha
    end
end