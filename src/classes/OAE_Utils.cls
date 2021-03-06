public with sharing class OAE_Utils {
	private static final Integer f_legalParamCount = 10;
	private static final Integer f_userColumns = 2;
	private static final Integer f_bitsPerLong = 60;
    public static final Long twoSixty = (1L<<60)-1;
    
    public static Long flipOn(Long bArray, Integer bit) {
        return flipOn(bArray, (Math.pow(2,bit-1)).longValue(), true);
    }
    
    public static Long flipOn(Long bArray, Long mask, boolean q) {
        return (bArray | mask);
    }

    public static Long flipOff(Long bArray, Integer bit) {
        return flipOff(bArray, (Math.pow(2,bit-1)).longValue(), true);
    }
    
    public static Long flipOff(Long bArray, Long mask, boolean q) {
        return (bArray & (twoSixty ^ mask));
    }
    
	public static Set<Integer> bitToSet(Long bitMap, Integer offset) {
		Set<Integer> retVal = new Set<Integer>();
		Long currentBit = 1;

		for (Integer i = 0; i < f_bitsPerLong; ) {
			i++;
			if ((currentBit & bitMap) != 0)
				retVal.add(i+offset);
			currentBit = currentBit << 1;
		}
		return retVal;
	}

	public static Map<Integer,Long> setToBit(Set<Integer> numSet) {
		Map<Integer,Long> retVal = new Map<Integer,Long>();
		
		for (Integer included : numSet) {
			Integer thisIndex = included / f_bitsPerLong;
			Long thisLong = retVal.get(thisIndex);
			if (thisLong == null) {
				retVal.put(thisIndex,1L<<(Math.mod(included,f_bitsPerLong)-1));
			} else 
				retVal.put(thisIndex, thisLong | 1L<<(Math.mod(included,f_bitsPerLong)-1));
		}
		return retVal;
	}

}