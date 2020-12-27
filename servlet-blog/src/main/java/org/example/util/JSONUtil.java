package org.example.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.io.InputStream;

public class JSONUtil {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    /**
     * JSON序列化：将java对象序列化为json字符串
     * @param o java对象
     * @return  json字符串
     */
    public static String serialize(Object o) {
        try {
            return MAPPER.writeValueAsString(o);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            throw new RuntimeException("json序列化失败"+o);
        }
    }


    /**
     * 反序列化操作：将 输入流/字符串反序列为java对象
     * @param is    输入流
     * @param c     指定要反序列化的类型
     * @param <T>
     * @return      反序列化的对象
     */
    public static <T> T desrialize(InputStream is,Class<T> c) {
        try {
            return MAPPER.readValue(is,c);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("反序列化失败"+c.getName());
        }
    }
}
