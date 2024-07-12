//定制请求的实例

//导入axios  npm install axios
import axios from 'axios';
import {ElMessage} from "element-plus";
import {useTokenStore} from "@/stores/token.js";
//调用router的第一种方式
import router from "@/router/index.js";
//调用router的第二种方式，但这种方式在响应拦截器中无法使用（由于组件加载顺序的原因访问不到）
// import {useRouter} from "vue-router";
// const router = useRouter()
//定义一个变量,记录公共的前缀  ,  baseURL
const baseURL = '/api';
const instance = axios.create({baseURL})


//添加请求拦截器
instance.interceptors.request.use(
    (config) => {
        const tokenStore = useTokenStore()
        if (tokenStore.token){
            //在pinia中定义的响应式数据,都不需要.value
            config.headers.Authorization = tokenStore.token
        }
        return config
    },
    (err) => {
        Promise.reject(err)
    }
)
//添加响应拦截器
instance.interceptors.response.use(
    result=>{
        if (result.data.code === 0){
            return result.data;
        }
        ElMessage.error(result.data.msg?result.data.msg:'服务异常')
        //异步操作的状态转换为失败
        return Promise.reject(result.data)
    },
    err=>{
        if (err.response.status === 401){
            ElMessage.error('请先登录')
            router.push('/login')
        }else {
            ElMessage.error('服务异常')
        }
        return Promise.reject(err);//异步的状态转化成失败的状态
    }
)

export default instance;
