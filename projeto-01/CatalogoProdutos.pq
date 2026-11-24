let
    Fonte = Excel.Workbook(File.Contents(CaminhoArquivoExcel), null, true),
    Catalogo = Fonte{[Item = "CatalogoProdutos", Kind = "Table"]}[Data],
    Colunas = Table.SelectColumns(Catalogo, {"ID_Produto", "Produto", "Categoria", "Custo_Referencia"}),
    Tipos = Table.TransformColumnTypes(Colunas, {
        {"ID_Produto", type text}, {"Produto", type text},
        {"Categoria", type text}, {"Custo_Referencia", Currency.Type}
    }, "pt-BR")
in
    Tipos
