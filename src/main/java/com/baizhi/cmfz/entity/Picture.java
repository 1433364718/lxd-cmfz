package com.baizhi.cmfz.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class Picture {
    private int id;
    private String picName;
    private String desc;
    private String url;
    private String status;

    @JSONField(format = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date date;


    /*JSONObjectjson=JSONObject.fromObject(request.getParameter("data"));
             List<Map<String,String>>edit=(List<Map<String,String>>)json.getJSONArray("edit");
            List<?>del=(List<?>)json.getJSONArray("del");*/

}
