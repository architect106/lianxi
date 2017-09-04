package com.kaika.util;

import java.util.HashMap;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * Created by sarem on 2016/4/28.
 */
public class JSONUtil {

    private static final String SUCCESS = "success";

    private static final String MESSAGE = "message";
    
    private static final String TOTAL = "total";

    private static final String ROWS = "rows";
    
    private static final String OPTIONS = "options";

    private static HashMap<String,Object> resultMap = null;

    //String to JSONObject
    public static JSONObject parseJSONObject(String text){
        return JSON.parseObject(text);
    }
    
    //obj to SimpleJSONString
    public static String toSimpleJSONString(Object obj){
        return JSON.toJSONString(obj);
    }
    
    //obj to JSONString
    private static String toJSONString(Object obj){
        return JSON.toJSONString(resultMap);
    }
    
    public static String getAllData(Object obj){
        resultMap = new HashMap<String,Object>();
        resultMap.put(ROWS,obj);
        return JSONUtil.toJSONString(resultMap);
    }
    
    public static String getPageData(Object obj,int total){
        resultMap = new HashMap<String,Object>();
        resultMap.put(ROWS,obj);
        resultMap.put(TOTAL,total);
        return JSONUtil.toJSONString(resultMap);
    }
    
    public static String getMessage(Boolean success,String Message){
        resultMap = new HashMap<String,Object>();
        resultMap.put(SUCCESS,success);
        resultMap.put(MESSAGE,Message);
        return JSONUtil.toJSONString(resultMap);
    }
    
    public static String getOptions(Object obj){
        resultMap = new HashMap<String,Object>();
        resultMap.put(OPTIONS,obj);
        return JSONUtil.toJSONString(resultMap);
    }
    
}
