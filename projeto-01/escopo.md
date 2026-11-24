# Projeto 1 | Vendas e margem no varejo

## Oferta comercial

Painel em Power BI para pequenos varejistas que registram pedidos e produtos no Excel. O gestor deve conseguir identificar se as vendas estão crescendo e quais produtos contribuem mais para a margem bruta estimada.

Preço de referência para a oferta inicial: **R$ 450**. O escopo inclui duas páginas, adaptação de uma planilha em formato combinado com o cliente, arquivo PBIX editável, instruções de atualização e uma rodada de ajustes. O orçamento pressupõe uma base utilizável e atualização manual pelo Power BI Desktop. Integrações, tratamento de bases fora do formato acordado e publicação em nuvem são serviços cotados à parte.

## Páginas

| Página | Decisão | Componentes |
| --- | --- | --- |
| Visão executiva | As vendas e a margem melhoraram? | Cartões de faturamento líquido, margem bruta estimada, percentual de margem e pedidos. Série de faturamento por mês e comparação com o mesmo mês do ano anterior quando houver histórico. |
| Produtos e margem | Quais produtos merecem atenção na precificação e no mix? | Ranking por margem bruta estimada e matriz por categoria e produto com receita, unidades, desconto, margem em reais e percentual. |

As duas páginas usam filtros de período e categoria em posição consistente. O layout em 16:9 prioriza cartões no topo, gráficos grandes, fundo claro, tipografia Segoe UI e títulos que descrevem a medida exibida. Azul-petróleo identifica a série principal e cinza identifica o ano anterior. Margens negativas usam cor e sinal de menos.

## Modelo e regras de negócio

- Usar `TabelaVendas` como fato no nível de linha do pedido. Relacionar com calendário e `CatalogoProdutos` por data e ID do produto.
- Calcular faturamento a partir de `Valor_Liquido` e conferir contra quantidade × preço unitário − desconto. Contar pedidos distintos pelo identificador.
- Estimar o custo por linha multiplicando quantidade por `Custo_Referencia`. A margem bruta estimada é receita menos custo estimado. O percentual divide a margem pela receita. O catálogo atual aplica um custo de referência a todas as datas. Um cliente com custos históricos exige outra fonte.
- Conferir a cobertura de custos antes de apresentar margem. Se qualquer linha do recorte estiver sem custo, deixar a margem em branco e informar a ausência. Deixar o percentual em branco quando a receita for zero.
- Usar comparações entre meses fechados e equivalentes. Quando faltar histórico, omitir a variação e indicar a indisponibilidade. Caso a base atual seja insuficiente para demonstrar essa comparação, complementar com dados sintéticos documentados.

## Critérios de entrega

1. Conciliar faturamento, pedidos e margem com o Excel no total e em um recorte de categoria e período.
2. Verificar os estados sem vendas, sem custo e sem histórico comparável.
3. Validar navegação, filtros, contraste e legibilidade das duas páginas no Power BI Desktop.
4. Atualizar o relatório com uma venda de teste em uma cópia da planilha e confirmar os resultados esperados.
5. Registrar duas decisões de negócio demonstradas pelo painel, com capturas finais e instruções de atualização no portfólio.

Para os próximos projetos, aplicar o mesmo critério de entrada no portfólio: um comprador definido, uma decisão comercial demonstrada, uma oferta de pelo menos R$ 300, design revisado e entrega reproduzível.

## Integração e valores de conferência

As consultas `CatalogoProdutos.pq` e `Calendario.pq` usam o parâmetro e a consulta de vendas existentes. No modelo, configurar relacionamentos ativos de um para muitos de `CatalogoProdutos[ID_Produto]` e `Calendario[Data]` para as chaves correspondentes em `TabelaVendas`, com filtro da dimensão para a fato. Marcar `Calendario` como tabela de datas e usar a categoria do catálogo e o mês do calendário nos filtros. Aplicar `medidas.dax` ao modelo e vincular as medidas aos visuais.

Valores calculados diretamente das duas tabelas do Excel:

| Recorte | Faturamento líquido | Pedidos | Unidades | Custo de referência total | Margem estimada | Margem % |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Base atual | R$ 58.743,60 | 611 | 960 | R$ 30.320,40 | R$ 28.423,20 | 48,39% |
| Cabos em janeiro de 2026 | R$ 636,75 | 17 | 20 | R$ 323,00 | R$ 313,75 | 49,27% |

A base contém 801 linhas, com vendas de janeiro a outubro de 2026. A fórmula de faturamento conferiu em todas as linhas ao centavo. A comparação anual fica em branco nessa base. A regra de comparação usa a primeira venda como início da cobertura e exclui o mês da última venda por precaução. Para uma implantação com calendário de fechamento informado pelo cliente, usar as datas de cobertura e fechamento declaradas na fonte.

## Base demonstrativa da V2

`Base_Vendas_V2.xlsx` mantém as 801 linhas de 2026 e inclui 801 linhas sintéticas em 2025. Para criar o histórico, as datas foram deslocadas em um ano, os pedidos receberam o prefixo `H25-` e os preços e descontos foram multiplicados por 0,92 e arredondados ao centavo. As quantidades e o catálogo foram mantidos. A diferença entre os anos ilustra o funcionamento da comparação com menor preço realizado no período anterior.

Em fevereiro, o faturamento líquido esperado é R$ 4.959,68 em 2025 e R$ 5.390,78 em 2026, uma variação de 8,69%. A base completa contempla R$ 112.789,72 de faturamento e 1.222 pedidos.

Para atualizar o projeto em outra máquina, defina `CaminhoArquivoExcel` em **Transformar dados → Gerenciar parâmetros** com o caminho do arquivo local e selecione **Atualizar**. Ao incluir uma venda em `TabelaVendas`, preencha `Valor_Liquido` com quantidade × preço unitário − desconto. A tabela `CatalogoProdutos` fornece o custo de referência por ID de produto.

## Validação no Power BI Desktop

- Ao restringir o período na Visão executiva, os cartões passaram a R$ 58.708,70 de faturamento, 610 pedidos e R$ 28.405,80 de margem estimada. O gráfico também respondeu ao intervalo.
- Ao limpar o filtro, a página voltou a R$ 112.789,72 de faturamento, 1.222 pedidos e R$ 52.148,92 de margem estimada.
- As duas páginas foram exportadas com o período completo e conferidas antes de incluir as imagens no README.
