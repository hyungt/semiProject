package kr.co.jtimes.util;

import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

public class JsonDateConvertor implements JsonSerializer<Date> {

	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	@Override
	public JsonElement serialize(Date date, Type type, JsonSerializationContext context) {
		if(date == null) {
			return new JsonPrimitive("");
		} else {
			return new JsonPrimitive(dateFormat.format(date));
		}
	}
	
}
