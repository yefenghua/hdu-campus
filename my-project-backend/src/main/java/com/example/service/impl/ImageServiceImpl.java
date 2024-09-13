package com.example.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.entity.dto.Account;
import com.example.entity.dto.StoreImage;
import com.example.mapper.AccountMapper;
import com.example.mapper.ImageStoreMapper;
import com.example.service.ImageService;
import com.example.utils.Const;
import com.example.utils.FlowUtils;
import io.minio.*;
import io.minio.errors.*;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.OutputStream;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@Slf4j
@Service
public class ImageServiceImpl extends ServiceImpl<ImageStoreMapper, StoreImage> implements ImageService {

    @Resource
    MinioClient client;

    @Resource
    AccountMapper mapper;

    @Resource
    FlowUtils flowUtils;

    private SimpleDateFormat format=new SimpleDateFormat("yyyyMMdd");

    @Override
    public String uploadAvatar(MultipartFile file, int id) throws IOException {
        String imageName= UUID.randomUUID().toString().replace("-","");
        imageName="/avatar/"+imageName;
        PutObjectArgs args=PutObjectArgs.builder()
                .bucket("study")
                .stream(file.getInputStream(),file.getSize(),-1)
                .object(imageName)
                .build();
        try{
            client.putObject(args);
            String avatar = mapper.selectById(id).getAvatar();
            this.deleteOldAvatar(avatar);
            if (mapper.update(null, Wrappers.<Account>update().eq("id",id).set("avatar",imageName))>0){
                return imageName;
            }else{
                return null;
            }
        }catch (Exception e){
            log.error("图片上传出现问题：{}",e.getMessage());
            return null;
        }
    }

    private void deleteOldAvatar(String avatar) throws Exception{
        if (avatar==null || avatar.isEmpty()) return;
        RemoveObjectArgs remove= RemoveObjectArgs.builder()
                .bucket("study")
                .object(avatar)
                .build();
        client.removeObject(remove);
    }

    @Override
    public String uploadImage(MultipartFile file, int id) throws IOException {
        String key= Const.Forum_IMAGE_COUNTER+id;
        if (!flowUtils.limitPeriodCounterCheck(key,20,3600))
            return null;
        String imageName= UUID.randomUUID().toString().replace("-","");
        Date date=new Date();
        imageName="/cache/"+format.format(date)+"/"+imageName;
        PutObjectArgs args=PutObjectArgs.builder()
                .bucket("study")
                .stream(file.getInputStream(),file.getSize(),-1)
                .object(imageName)
                .build();
        try{
            client.putObject(args);
            if (this.save(new StoreImage(id,imageName,date))){
                return imageName;
            }else
                return null;
        }catch (Exception e){
            log.error("图片上传出现问题：{}",e.getMessage());
            return null;
        }
    }

    @Override
    public void fetchImageFromMinio(OutputStream stream, String image) throws Exception {
        GetObjectArgs args= GetObjectArgs.builder()
                .bucket("study")
                .object(image)
                .build();
        GetObjectResponse response=client.getObject(args);
        IOUtils.copy(response,stream);
    }
}
