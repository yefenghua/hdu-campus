<script setup>
import LightCard from "@/components/LightCard.vue";
import {
    Calendar, CircleCheck,
    Clock,
    CollectionTag,
    Compass,
    Document,
    Edit,
    EditPen,
    Link,
    Microphone,
    Picture, Star
} from "@element-plus/icons-vue";
import Weather from "@/components/Weather.vue";
import {computed, reactive, ref, watch} from "vue";
import {get} from "@/net";
import {ElMessage} from "element-plus";
import TopicEditor from "@/components/TopicEditor.vue";
import {useStore} from "@/store";
import axios from "axios";
import ColorDot from "@/components/ColorDot.vue";
import router from "@/router";
import TopicTag from "@/components/TopicTag.vue";

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
const topics=reactive({
    list:[],
    type:0,
    page:1,
    end:false,
    top:[]
})

watch(()=>topics.type,()=> {
    resetList()
},{immediate:true})


get("/api/forum/top-topic",data=> {
    topics.top = data
})
function updateList(){
    if (topics.end) return;
    get(`/api/forum/list-topic?page=${topics.page}&type=${topics.type}`, data=> {
        if (data){
            data.forEach(d=>topics.list.push(d))
            topics.page++
        }
        if (!data||data.length<10)
            topics.end=true
    })
}

function onTopicCreate(){
    editor.value=false
    resetList()

}

function resetList(){
    topics.page=1
    topics.end=false
    topics.list=[]
    updateList()
}

navigator.geolocation.getCurrentPosition(position => {
    const longitude = position.coords.longitude
    const latitude = position.coords.latitude
    get(`/api/forum/weather?longitude=${longitude}&latitude=${latitude}`, data => {
        Object.assign(weather, data)
        weather.success = true
    })
}, error => {
    console.info(error)
    ElMessage.warning('位置信息获取超时，请检测网络设置')
    get(`/api/forum/weather?longitude=116.40529&latitude=39.90499`, data => {
        Object.assign(weather, data)
        weather.success = true
    })
}, {
    timeout: 3000,
    enableHighAccuracy: true
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
            <div style="margin-top: 10px;display: flex;gap: 13px;font-size: 18px;color: grey">
                <el-icon><Edit /></el-icon>
                <el-icon><Document /></el-icon>
                <el-icon><Compass /></el-icon>
                <el-icon><Picture /></el-icon>
                <el-icon><Microphone /></el-icon>
            </div>
        </light-card>
        <light-card style="margin-top: 10px;display: flex;flex-direction: column;gap: 10px">
            <div v-for="item in topics.top" class="top-topic" @click="router.push(`/index/topic-detail/${item.id}`)">
                <el-tag type="danger" size="small">置顶</el-tag>
                <div>{{item.title}}</div>
                <div>{{new Date(item.time).toLocaleString()}}</div>
            </div>
        </light-card>
        <light-card style="margin-top: 10px;display:flex;gap:7px;">
            <div :class="`type-select-card ${topics.type===item.id ? 'active':''}`" v-for="item in store.forum.types" @click="topics.type=item.id">
                <color-dot :color="item.color"/>
                <span style="margin-left: 5px;">{{item.name}}</span>
            </div>
        </light-card>
        <transition name="el-fade-in" mode="out-in">
            <div v-if="topics.list.length">
                <div style="margin-top: 10px;display: flex;flex-direction: column;gap: 10px" v-infinite-scroll="updateList">
                    <light-card v-for="item in topics.list" class="topic-card" @click="router.push('/index/topic-detail/'+item.id)">
                        <div>
                            <div style="display: flex">
                                <div>
                                    <el-avatar :size="30" :src="`${axios.defaults.baseURL}/images${item.avatar}`"/>
                                </div>
                                <div style="margin-left: 7px;transform: translateY(-2px)">
                                    <div style="font-size: 13px;font-weight: bold;">
                                        {{item.username}}
                                    </div>
                                    <div style="font-size: 12px;color:grey">
                                        <el-icon><Clock/></el-icon>
                                        <div style="margin-left: 2px;display: inline-block;transform: translateY(-2px)">{{new Date(item.time).toLocaleString()}}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <topic-tag :type="item.type"/>
                            <span style="font-weight: bold;margin-left: 7px;">
                        {{item.title}}
                    </span>
                        </div>
                        <div class="topic-content">{{item.text}}</div>
                        <div style="display: grid;grid-template-columns: repeat(3,1fr);gap: 10px">
                            <el-image class="topic-image" v-for="img in item.images" :src="img">

                            </el-image>
                            <div style="display: flex;gap: 20px;font-size: 13px;margin-top: 10px;opacity: 0.8">
                                <div>
                                    <el-icon style="vertical-align: middle"><CircleCheck/></el-icon> {{item.like}}点赞
                                </div>
                                <div>
                                    <el-icon style="vertical-align: middle"><Star/></el-icon> {{item.collect}}收藏
                                </div>
                            </div>
                        </div>
                    </light-card>
                </div>
            </div>
        </transition>



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
        <topic-editor :show="editor" @success="onTopicCreate" @close="editor=false"/>
    </div>
</div>
</template>

<style lang="less" scoped>
.top-topic{
    display: flex;

    div:first-of-type{
        font-size: 14px;
        margin-left: 10px;
        font-weight: bold;
        opacity: 0.85;

        transition: color .3s;

        &:hover{
            color:grey;
        }
    }

    div:nth-of-type(2){
        flex: 1;
        color: grey;
        font-size: 13px;
        text-align: right;
    }

    &:hover{
        cursor: pointer;
    }
}

.type-select-card{
    background-color: #fbfbfb;
    padding: 2px 7px;
    font-size: 14px;
    border-radius: 3px;
    box-sizing: border-box;

    transition: background-color .3s;

    &.active{
        border: solid 1.5px #409eff;
    }

    &:hover{
        cursor: pointer;
        background-color: #dadada;
    }
}

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

    .topic-image{
        width: 100%;
        height: 100%;
        max-height: 110px;
        border-radius: 5px;
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

.dark {
    .create-topic {
        background-color: #232323;
    }

    .type-select-card{
        background-color: #282828;

        &.active{
            border: solid 1.5px #64594b;
        }

        &:hover{
            cursor: pointer;
            background-color: #5e5e5e;
        }

    }
}
</style>