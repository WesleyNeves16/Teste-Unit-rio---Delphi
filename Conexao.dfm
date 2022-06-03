object DmDados: TDmDados
  OldCreateOrder = False
  Height = 153
  Width = 291
  object Conexao: TUniConnection
    AutoCommit = False
    ProviderName = ''
    Database = 'TesteUnit'
    Username = ''
    Server = ''
    Connected = True
    Left = 88
    Top = 40
    EncryptedPassword = ''
  end
  object TbUsuario: TUniQuery
    Connection = Conexao
    AutoCalcFields = False
    Left = 176
    Top = 40
  end
end
