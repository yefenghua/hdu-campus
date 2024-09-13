<script setup>
import Card from "@/components/Card.vue";
import LightCard from "@/components/LightCard.vue";
import {Calendar, Cloudy, CollectionTag, EditPen, Link, Sunny, Tools} from "@element-plus/icons-vue";
import Weather from "@/components/Weather.vue";
import {computed, reactive, ref} from "vue";
import {get} from "@/net";
import {ElMessage} from "element-plus";
import TopicEditor from "@/components/TopicEditor.vue";
import {useStore} from "@/store";

const store=useStore()

const today=computed(()=>{
    const date=new Date()
    return `${date.getFullYear()} 年 ${date.getMonth() + 1} 月 ${date.getDate()} 日`
})

const weather=reactive(({
    location:{},
    now:{},
    hourly:[],
    success:false
}))

const editor=ref(false)
const list=ref(null)

get(`/api/forum/list-topic?page=0&type=0`, data=>list.value=data)

get('/api/forum/types',data=> store.forum.types=data)

navigator.geolocation.getCurrentPosition(position=>{
    const longitude=position.coords.longitude
    const latitude=position.coords.latitude
    get(`/api/forum/weather?longitude=${longitude}&latitude=${latitude}`,data=>{
        Object.assign(weather,data)
        weather.success=true
    },error=>{
        console.info(error)
        ElMessage.warning('位置信息获取超时，请检查网络设置')
        get('api/forum/weatherr?longitude=116.3912757&latitude=39.906217',data=>{
            Object.assign(weather,data)
            weather.success=true
        })
    },{
        timeout:3000,
        enableHighAccuracy:true,
    })
})
</script>

<template>
<div style="display: flex;margin: 20px auto;gap:20px;max-width: 900px;">
    <div style="flex: 1;">
        <light-card>
            <div class="create-topic" @click="editor=true">
                <el-icon style="translate: 0 2px;"><EditPen/></el-icon>
                点击发表主题...
            </div>
        </light-card>
        <light-card style="margin-top: 10px;height: 30px">

        </light-card>
        <div style="margin-top: 10px;display: flex;flex-direction: column;gap: 10px">
            <light-card v-for="item in list" class="topic-card">
                <div>
                    <div class="topic-type" :style="{
                        color: store.findTypeByID(item.type).color+'EE',
                        borderColor: store.findTypeByID(item.type).color+'77',
                        backgroundColor: store.findTypeByID(item.type).color+'30',
                    }">
                        {{store.findTypeByID(item.type).name}}
                    </div>
                    <span style="font-weight: bold;margin-left: 7px;">
                        {{item.title}}
                    </span>
                </div>
                <div class="topic-content">{{item.text}}</div>
            </light-card>
        </div>

    </div>
    <div style="width: 280px;">
        <div style="position: sticky;top:20px;">
            <light-card>
                <div style="font-weight: bold">
                    <el-icon style="translate: 0 2px"><CollectionTag/></el-icon>
                    论坛公告
                </div>
                <el-divider style="margin: 10px 0"/>
                <div style="font-size: 14px;margin: 10px;color: grey">
                    的回到发好啊采访的花朵，方才到擦查曹超擦。朝参哦擦和建！安十年后擦汗从
                </div>
            </light-card>
            <light-card style="margin-top: 10px;">
                <div style="font-weight: bold">
                    <el-icon style="translate: 0 2px"><Calendar/></el-icon>
                    天气信息
                </div>
                <el-divider style="margin: 10px 0"/>
                <weather :data="weather"/>
            </light-card>
            <light-card style="margin-top: 10px;">
                <div class="info-text">
                    <div>当前日期</div>
                    <div>{{today}}</div>
                </div>
                <div class="info-text">
                    <div>当前ip地址</div>
                    <div>127.0.0.1</div>
                </div>
            </light-card>
            <div style="font-size: 14px;margin-top: 10px;color: grey">
                <el-icon><Link/></el-icon>
                友情链接
                <el-divider style="margin: 10px 0"/>
            </div>
            <div style="display: grid;grid-template-columns: repeat(2,1fr);grid-gap: 10px">
                <div class="friend-link">
                    <el-image style="height: 100%" src="https://element-plus.org/images/sponsors/mele-banner.png"/>
                </div>
                <div class="friend-link">
                    <el-image style="height: 100%" src="https://element-plus.org/images/sponsors/vform-banner.png"/>
                </div>
                <div class="friend-link">
                    <el-image style="height: 100%" src="https://element-plus.org/images/sponsors/jnpfsoft.jpg"/>
                </div>
            </div>
        </div>
        <topic-editor :show="editor" @success="editor=false" @close="editor=false"/>
    </div>
</div>
</template>

<style lang="less" scoped>
.topic-card{
    padding:15px;

    transition: scale .3s;

    &:hover{
        scale: 1.015;
        cursor: pointer;
    }

    .topic-content{
        font-size: 13px;
        color:grey;
        margin:5px 0;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 3;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .topic-type{
        display: inline-block;
        border: solid 0.5px grey;
        border-radius: 5px;
        font-size: 12px;
        padding: 0 5px;
        height: 18px;
        translate: 0 -1px;
    }
}

.info-text{
    display: flex;
    justify-content: space-between;
    color: grey;
    font-size: 14px;
}
.friend-link{
    border-radius: 5px;
    overflow: hidden;
}
.create-topic{
    background-color: #efefef;
    height: 40px;
    border-radius: 5px;
    font-size: 14px;
    line-height: 40px;
    padding: 0 10px;
    color: grey;

    &:hover{
        cursor: pointer;
    }
}

.dark .create-topic{
    background-color: #232323;
}
</style>