<script setup>
import { ref } from 'vue'
import {userPasswordUpdateService} from "@/api/user.js";
import {ElMessage} from "element-plus";
const userInfo = ref({
  id: 0,
  username: 'zhangsan',
  nickname: 'zs',
  email: 'zs@163.com',
})

const passwordData = ref({
  oldPassword:'',
  newPassword:'',
  reNewPassword:''
})

//校验密码的函数
const checkReNewPassword = (rule,value,callback) => {
  if (value === ''){
    callback(new Error('请再次输入新密码'))
  }else if (value !== passwordData.value.newPassword){
    callback(new Error('请确保两次输入的新密码一样'))
  }else {
    callback()
  }
}

const rules = {
  oldPassword:[
    {required:true,message:'请输入原密码',trigger:'blur'},
    // {min:5,max:16,message:'长度为5~16位非空字符',trigger: 'blur'}
  ],
  newPassword:[
    {required:true,message:'请输入新密码',trigger:'blur'},
    {min:5,max:16,message:'长度为5~16位非空字符',trigger: 'blur'}
  ],
  reNewPassword:[
    {validator:checkReNewPassword,trigger:'blur'}
  ]
}

const updatePassword = async () => {
  let params = {
    old_pwd : passwordData.value.oldPassword,
    new_pwd : passwordData.value.newPassword,
    re_pwd : passwordData.value.reNewPassword
  }
  console.log(params)
  let result = await userPasswordUpdateService(params)
  ElMessage.success(result.msg?result.msg:'修改密码成功')
}

const clearData = () => {
  passwordData.value = {}
}

</script>
<template>
  <el-card class="page-container">
    <template #header>
      <div class="header">
        <span>重置密码</span>
      </div>
    </template>
    <el-row>
      <el-col :span="12">
        <el-form :model="passwordData" :rules="rules" label-width="100px" size="large">
          <el-form-item label="原密码" prop="oldPassword">
            <el-input v-model="passwordData.oldPassword" type="password"></el-input>
          </el-form-item>
          <el-form-item label="新密码" prop="newPassword">
            <el-input v-model="passwordData.newPassword" type="password"></el-input>
          </el-form-item>
          <el-form-item label="确认新密码" prop="reNewPassword">
            <el-input v-model="passwordData.reNewPassword" type="password"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="updatePassword">修改密码</el-button>
            <el-button type="default" @click="clearData">重置</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
  </el-card>
</template>
