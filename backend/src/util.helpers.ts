export const aggregateQuery = (filteredOrders: any, array: any, x: any) => {
  return {
    avg_Anfahrt:
      filteredOrders.reduce((a: any, b: { Anfahrt: any }) => a + (b.Anfahrt ?? 0), 0) /
      array.filter((order: { MitID: any }) => order.MitID === x).length,
    avg_Dauer:
      filteredOrders.reduce(
        (a: any, b: { Dauer: any }) => Number(a) + Number(b.Dauer),
        0
      ) / array.filter((order: { MitID: any }) => order.MitID === x).length,
    avg_RechBetrag:
      filteredOrders.reduce(
        (a: any, b: { Rechnung: { RechBetrag: any }[] }) => a + b.Rechnung[0].RechBetrag,
        0
      ) / array.filter((order: { MitID: any }) => order.MitID === x).length,
    max_Anfahrt: Math.max(
      ...filteredOrders.map((o: { Anfahrt: any }) => Number(o.Anfahrt))
    ),
    max_Dauer: Math.max(...filteredOrders.map((o: { Dauer: any }) => Number(o.Dauer))),
    max_RechBetrag: Math.max(
      ...filteredOrders.map(
        (o: { Rechnung: { RechBetrag: any }[] }) => o.Rechnung[0].RechBetrag
      )
    ),
    min_Anfahrt: Math.min(
      ...filteredOrders.map((o: { Anfahrt: any }) => Number(o.Anfahrt))
    ),
    min_Dauer: Math.min(...filteredOrders.map((o: { Dauer: any }) => Number(o.Dauer))),
    min_RechBetrag: Math.min(
      ...filteredOrders.map(
        (o: { Rechnung: { RechBetrag: any }[] }) => o.Rechnung[0].RechBetrag
      )
    ),
    sum_Anfahrt: filteredOrders.reduce(
      (a: number, b: { Anfahrt: any }) => a + Number(b.Anfahrt),
      0
    ),
    sum_Dauer: filteredOrders.reduce(
      (a: number, b: { Dauer: any }) => a + Number(b.Dauer),
      0
    ),
    sum_RechBetrag: filteredOrders.reduce(
      (a: any, b: { Rechnung: { RechBetrag: any }[] }) => (a += b.Rechnung[0].RechBetrag),
      0
    ),
  };
};
