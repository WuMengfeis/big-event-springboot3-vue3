import { fileURLToPath, URL } from 'node:url'

import { defineConfig,loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig(({mode})=>{
  // 加载环境变量
  const env = loadEnv(mode, process.cwd());
  return{
    plugins: [
      vue(),
    ],
    resolve: {
      alias: {
        '@': fileURLToPath(new URL('./src', import.meta.url))
      }
    },
    server:{
      proxy:{
        '/api':{
          target:env.VITE_API_TARGET,
          changeOrigin:true,
          rewrite:(path)=>path.replace(/^\/api/,'')
        }
      }
    }
  }
})
