package kr.co.jtimes.citizenrep.util;

public class StringUtils {
	/**
	 * 문자열의 값이 null이면 빈 문자열 반환
	 * @param str 원본문자열
	 * @return 빈문자나 원본 문자열
	 */
	public static String nullToBlank(String str){
		if(str==null){
			return "";
		}else return str.trim();
	}
	
	/**
	 * 숫자들로 구성된 문자열을 정수값으로 변환뒤 반환
	 * @param str 숫자로 구성된 문자열
	 * @return 변환된 정수값, 문자열이 숫자로 구성되어있지 않거나 null이면 0을 반환
	 */
	public static int strToNumber(String str){
		return strToNumber(str, 0);
	}
	
	/**
	 * 숫자들로 구성된 문자열을 정수값으로 변환해서 반환
	 * 문지열을 숫자로 변환 중 오류가 발생하면 기본값으로 지정된 값을 반환
	 * @param str 숫자로 구성된 문자열
	 * @param defaultValue 기본값
	 * @return 변환된 정수값, 문자열이 숫자로 구성되어 있지 않거나 null이면 기본값을 반환한다.
	 */
	public static int strToNumber(String str, int defaultValue) {
		if(str==null){
			return defaultValue;
		}
		try {
			return Integer.parseInt(str);
		} catch (Exception e) {
			// TODO: handle exception
			return defaultValue;
		}
	}
}
