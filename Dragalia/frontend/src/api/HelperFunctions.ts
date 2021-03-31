import { MaterialData } from './DataInterfaces';

const numberArrayComparator = (
  n1: number[] | undefined,
  n2: number[] | undefined,
) => {
  if (n1 === undefined) {
    return -1;
  } else if (n2 === undefined) {
    return 0;
  } else {
    for (let i = 0; i < Math.max(n2.length, n2.length); i++) {
      const e1 = n1[i];
      const e2 = n2[i];
      if (e1 === undefined || e1 < e2) {
        return -1;
      } else if (e2 === undefined || e1 > e2) {
        return 1;
      }
    }
  }
  return 0;
};

export const sortPathComparator = (sp1: string, sp2: string) => {
  const toSortPathArray = (sp: string) =>
    sp
      .split('/')
      .filter((sp) => sp)
      .map((sp) => sp.split('.').map((f) => parseInt(f)));
  const sp1arr = toSortPathArray(sp1);
  const sp2arr = toSortPathArray(sp2);

  for (let i = 0; i < Math.max(sp1arr.length, sp2arr.length); i++) {
    const e1 = sp1arr[i];
    const e2 = sp2arr[i];
    const eComp = numberArrayComparator(e1, e2);
    if (e1 === undefined || eComp === -1) {
      return -1;
    } else if (e2 === undefined || eComp === 1) {
      return 1;
    }
  }
  return 0;
};

export const materialComparator = (m1: MaterialData, m2: MaterialData) => {
  return sortPathComparator(m1.sortPath, m2.sortPath);
};

export const needed = (
  cost: number | undefined,
  inventory: number | undefined,
): number => {
  if (cost === undefined || inventory === undefined) {
    return 0;
  } else {
    return Math.max(0, cost - inventory);
  }
};
