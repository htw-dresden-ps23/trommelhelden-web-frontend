export const convertFilterOperator = (operator: string): string => {
  const operators: any = {
    startsWith: "startsWith",
    contains: "contains",
    notContains: "not",
    endsWith: "endsWith",
    equals: "equals",
    notEquals: "not",
    in: "in",
    between: "",
    lt: "lt:",
    lte: "lte",
    gt: "gt",
    gte: "gte",
    dateIs: "equals",
    dateIsNot: "not",
    dateBefore: "lte",
    dateAfter: "gte",
  };
  return operators[operator];
};
