package com.example.entity.vo.response;

import com.example.entity.BaseData;
import lombok.Data;

@Data
public class AccountPrivacyVO{
    boolean phone;
    boolean email;
    boolean wx;
    boolean qq;
    boolean gender;
}
