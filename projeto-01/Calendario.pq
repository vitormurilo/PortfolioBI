let
    DatasVendas = List.RemoveNulls(TabelaVendas[Data_Venda]),
    Hoje = Date.From(DateTime.FixedLocalNow()),
    Inicio = Date.StartOfYear(List.Min(DatasVendas, Hoje)),
    Fim = Date.EndOfYear(List.Max(DatasVendas, Hoje)),
    Datas = List.Dates(Inicio, Duration.Days(Fim - Inicio) + 1, #duration(1, 0, 0, 0)),
    Calendario = Table.TransformColumnTypes(
        Table.FromList(Datas, Splitter.SplitByNothing(), {"Data"}), {{"Data", type date}}
    ),
    ComMes = Table.AddColumn(Calendario, "InicioMes", each Date.StartOfMonth([Data]), type date)
in
    ComMes
