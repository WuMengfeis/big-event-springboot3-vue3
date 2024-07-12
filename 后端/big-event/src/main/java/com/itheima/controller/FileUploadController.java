package com.itheima.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.itheima.pojo.Result;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

@RestController
public class FileUploadController {

    @Value("${files.upload.path}")
    private String fileUploadPath;

    @Value("${server.ip}")
    private String serverIp;

    @Value("${files.upload.socket}")
    private String socket;


    /*@PostMapping("/upload")
    public Result<String> upload(MultipartFile file) throws Exception {
        //把文件的内容存储到本地磁盘上
        String originalFilename = file.getOriginalFilename();
        //保证文件的名字是唯一的,从而防止文件覆盖
        String filename = UUID.randomUUID().toString()+originalFilename.substring(originalFilename.lastIndexOf("."));
        //file.transferTo(new File("C:\\Users\\Administrator\\Desktop\\files\\"+filename));
        String url = AliOssUtil.uploadFile(filename,file.getInputStream());
        return Result.success(url);
    }*/

    @PostMapping("/upload")
    public Result<String> upload(@RequestParam MultipartFile file) throws IOException {
        String md5 = DigestUtils.md5Hex(file.getInputStream());
        String originalFilename = file.getOriginalFilename();
        String type = FileUtil.extName(originalFilename);
        long size = file.getSize();

        //定义一个文件唯一标识码
        String uuid = IdUtil.fastSimpleUUID();
        String fileUUID = uuid + StrUtil.DOT +type;
        System.out.println(fileUploadPath);
        File uploadFile = new File(fileUploadPath + fileUUID);
        System.out.println(uploadFile);
        //判断配置的文件目录是否存在，若不存在则创建一个新的文件目录
        File parentFile = uploadFile.getParentFile();
        if (!parentFile.exists()){
            parentFile.mkdirs();
        }

        String url = null;
        boolean fileExists = false;
        File[] files = parentFile.listFiles();
        if (files != null) {
            for (File oldFile : files) {
                String fileMd5 = DigestUtils.md5Hex(new FileInputStream(oldFile));
                if (fileMd5.equals(md5)) {
//                    url = "http://"+serverIp+":8080/file/"+oldFile.getName();
                    url = "/file/"+oldFile.getName();
                    // 本地文件夹若存在重复文件，则删除刚才上传的文件
                    uploadFile.delete();
                    fileExists = true;
                    break;

                }
            }
        }
        if (!fileExists) {
            //上传文件到磁盘
            file.transferTo(uploadFile);
            url = "/file/" + fileUUID;
        }
        return Result.success(url);
    }

    /**
     * 文件下载接口 http://localhost:8080/file/{fileUUID}
     * @param fileUUID
     * @param response
     * @throws IOException
     */

    @GetMapping("/file/{fileUUID}")
    public void download(@PathVariable String fileUUID, HttpServletResponse response) throws IOException {
        // 根据文件的唯一标识获取文件
        File uploadFile = new File(fileUploadPath + fileUUID);
        // 设置输出流的格式
        ServletOutputStream os = response.getOutputStream();
        response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileUUID, "UTF-8"));
        response.setContentType("application/octet-stream");

        //读取文件的字节流
        os.write(FileUtil.readBytes(uploadFile));
        os.flush();
        os.close();
    }
}
