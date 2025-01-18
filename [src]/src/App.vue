<template>
  <div class="mainscreen overflow-hidden py-36 w-screen h-screen  border flex justify-center items-end" style="display: none;">
    <div
      class="w-fit transition-all min-w-[13.25rem] overflow-hidden relative py-2 h-fit justify-between flex gap-4 items-center px-4 bg-[rgba(13,13,13,0.81)] border-b-[1px] backdrop-filter-[blur(1px)]"
      :style="{
        borderTopLeftRadius: '3px',
        borderTopRightRadius: '3px',
        borderBottomColor: startColor,
      }"
    >
      <div
        class="w-full -mx-4 h-[0.15rem] top-0 absolute transition-all"
        :style="{
          background: `linear-gradient(90deg, rgba(${getRGBA(startColor)}, 0.3) 0%, rgba(${getRGBA(startColor)}, 1) 50%, rgba(${getRGBA(startColor)}, 0.3) 100%)`,
        }"
      ></div>
      <div class="flex justify-center items-center gap-2">
        <div class="relative gap-2 flex justify-center items-center">
          <circle-progress
            :percent="percent"
            size="45"
            border-width="3"
            border-bg-width="5"
            class="absolute"
            empty-color="#000000"
            :fill-color="startColor"
            transition="50"
          />
          <div class="absolute">
            <div v-html="icon"></div>
          </div>
        </div>
        <div class="flex flex-col">
          <p class="font-semibold text-white/70 text-sm">{{ content }}</p>
          <p class="font-semibold text-white text-lg">{{ timeDisplay }}</p>
        </div>
      </div>
      <div class="flex justify-center items-center w-[1.5vw] h-[1.5vw] text-white font-bold rounded-full bg-[rgba(255,255,255,0.06)] p-2">
        {{ escapekey }}
      </div>
    </div>
  </div>
</template>








<script>
import "vue3-circle-progress/dist/circle-progress.css";
import CircleProgress from "vue3-circle-progress";
import $ from "jquery";
export default {
  name: "App",
  data() {
    return {
      icon : null,
      startColor : "#88E5FA",
      escapekey : null,
      percent: 100, 
      value: 10000, 
      timeDisplay: "00:00", 
      content : "Eating",
      animationFrameId : null,
    };
  },
  components: {
    CircleProgress,
  },
  methods: {
    EventHandler(event) {
      switch (event.data.action) {
        case "startAction":
          this.escapekey = event.data.escapeKey;
          this.startColor = "#88E5FA";
          this.StartAction(event.data.timer, event.data.icon, event.data.content);
          break;
        case "stopAction":
          this.StopAction()
          break;
        default:
          break;
      }
    },
    getRGBA(hexColor) {
      const hex = hexColor.replace("#", "");
      const bigint = parseInt(hex, 16);
      const r = (bigint >> 16) & 255;
      const g = (bigint >> 8) & 255;
      const b = bigint & 255;
      return `${r}, ${g}, ${b}`;
    },
    StopAction() {
      this.startColor = "#FA888A";
      this.timeDisplay = "CANCELLED";
      if (this.animationFrameId) {
        cancelAnimationFrame(this.animationFrameId);
        this.animationFrameId = null; 
      }
      this.icon = `
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12 2.25C10.0716 2.25 8.18657 2.82183 6.58319 3.89317C4.97982 4.96451 3.73013 6.48726 2.99218 8.26884C2.25422 10.0504 2.06114 12.0108 2.43735 13.9021C2.81355 15.7934 3.74215 17.5307 5.10571 18.8943C6.46928 20.2579 8.20656 21.1865 10.0979 21.5627C11.9892 21.9389 13.9496 21.7458 15.7312 21.0078C17.5127 20.2699 19.0355 19.0202 20.1068 17.4168C21.1782 15.8134 21.75 13.9284 21.75 12C21.7473 9.41498 20.7192 6.93661 18.8913 5.10872C17.0634 3.28084 14.585 2.25273 12 2.25ZM15.5306 14.4694C15.6003 14.5391 15.6556 14.6218 15.6933 14.7128C15.731 14.8039 15.7504 14.9015 15.7504 15C15.7504 15.0985 15.731 15.1961 15.6933 15.2872C15.6556 15.3782 15.6003 15.4609 15.5306 15.5306C15.4609 15.6003 15.3782 15.6556 15.2872 15.6933C15.1961 15.731 15.0986 15.7504 15 15.7504C14.9015 15.7504 14.8039 15.731 14.7128 15.6933C14.6218 15.6556 14.5391 15.6003 14.4694 15.5306L12 13.0603L9.53063 15.5306C9.46095 15.6003 9.37822 15.6556 9.28718 15.6933C9.19613 15.731 9.09855 15.7504 9 15.7504C8.90146 15.7504 8.80388 15.731 8.71283 15.6933C8.62179 15.6556 8.53906 15.6003 8.46938 15.5306C8.3997 15.4609 8.34442 15.3782 8.30671 15.2872C8.269 15.1961 8.24959 15.0985 8.24959 15C8.24959 14.9015 8.269 14.8039 8.30671 14.7128C8.34442 14.6218 8.3997 14.5391 8.46938 14.4694L10.9397 12L8.46938 9.53063C8.32865 9.38989 8.24959 9.19902 8.24959 9C8.24959 8.80098 8.32865 8.61011 8.46938 8.46937C8.61011 8.32864 8.80098 8.24958 9 8.24958C9.19903 8.24958 9.3899 8.32864 9.53063 8.46937L12 10.9397L14.4694 8.46937C14.5391 8.39969 14.6218 8.34442 14.7128 8.3067C14.8039 8.26899 14.9015 8.24958 15 8.24958C15.0986 8.24958 15.1961 8.26899 15.2872 8.3067C15.3782 8.34442 15.4609 8.39969 15.5306 8.46937C15.6003 8.53906 15.6556 8.62178 15.6933 8.71283C15.731 8.80387 15.7504 8.90145 15.7504 9C15.7504 9.09855 15.731 9.19613 15.6933 9.28717C15.6556 9.37822 15.6003 9.46094 15.5306 9.53063L13.0603 12L15.5306 14.4694Z" fill="white"/>
</svg>

      `
      const decreasePercent = () => {
        if (this.percent > 100) {
          this.percent += 1; 
          setTimeout(decreasePercent, 700); 
        } else {
          this.percent = 100; 
        }
      };

      decreasePercent(); 

      setTimeout(() => {
        $(".mainscreen").fadeOut(200);
      }, 700);

      setTimeout(() => {
        this.icon = null;
      }, 800);
    },

    StartAction(timer, icon, content) {
      this.content = content;
      this.value = timer; 
      this.icon = icon;
      this.percent = 100; 
      const duration = timer; 
      const startTime = performance.now();

      const update = () => {
        const currentTime = performance.now(); 
        const elapsed = currentTime - startTime;
        const remaining = Math.max(duration - elapsed, 0); 
        this.percent = (remaining / duration) * 100;
        const seconds = Math.floor(remaining / 1000);
        const milliseconds = Math.floor((remaining % 1000) / 10); 
        this.timeDisplay = `${seconds.toString().padStart(2, "0")}:${milliseconds
          .toString()
          .padStart(2, "0")}`;

        if (remaining > 0) {
          this.animationFrameId = requestAnimationFrame(update); 
        } else {
          
          $(".mainscreen").fadeOut(200); 
          $.post("https://uiforge-progressbar/FinishAction");
          setTimeout(() => {
            this.icon = null;
            this.percent = 100; 
            this.timeDisplay = "00:00";
          }, 200);
          
        }
      };
      $(".mainscreen").fadeIn(200); 
      this.animationFrameId = requestAnimationFrame(update); 
    },
  },
  mounted() {
    window.addEventListener("message", this.EventHandler);
  },
};
</script>


<style>

* {
  font-family: 'Poppins'
}
body {
  width : 100vw;
  height : 100vh
}

::-webkit-scrollbar {
  display: none;
}

@tailwind base;
@tailwind components;
@tailwind utilities;

@import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');

</style>
