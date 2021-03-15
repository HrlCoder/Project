package com.jian.sys.vo;

import com.jian.sys.pojo.User;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class UserVo extends User {
    private  Integer page;
    private Integer limit;
    private String code;
}
