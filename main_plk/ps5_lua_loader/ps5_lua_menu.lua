
menu_version = "0.1"

if not is_jailbroken() then
    send_ps_notification("This script requires a jailbroken PS5.\nRun kernel exploit (e.g. umtx.lua) first")
    return
end

syscall.resolve({
    unlink = 10,
    recv = 29,
    getsockname = 32,
    kill = 37,
    fcntl = 92,
    fsync = 95,
    send = 133,
    mkdir = 136,
    stat = 188, -- sys_stat2
    getdents = 272,
})

SERVER_PORT = 8084

local HTML_CONTENT = [[
<!DOCTYPE html>
<html>
<head>
    <title>PLK's Lua Menu</title>
    <script>
        // qrcode.min.js, src: https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js
        var QRCode;!function(){function a(a){this.mode=c.MODE_8BIT_BYTE,this.data=a,this.parsedData=[];for(var b=[],d=0,e=this.data.length;e>d;d++){var f=this.data.charCodeAt(d);f>65536?(b[0]=240|(1835008&f)>>>18,b[1]=128|(258048&f)>>>12,b[2]=128|(4032&f)>>>6,b[3]=128|63&f):f>2048?(b[0]=224|(61440&f)>>>12,b[1]=128|(4032&f)>>>6,b[2]=128|63&f):f>128?(b[0]=192|(1984&f)>>>6,b[1]=128|63&f):b[0]=f,this.parsedData=this.parsedData.concat(b)}this.parsedData.length!=this.data.length&&(this.parsedData.unshift(191),this.parsedData.unshift(187),this.parsedData.unshift(239))}function b(a,b){this.typeNumber=a,this.errorCorrectLevel=b,this.modules=null,this.moduleCount=0,this.dataCache=null,this.dataList=[]}function i(a,b){if(void 0==a.length)throw new Error(a.length+"/"+b);for(var c=0;c<a.length&&0==a[c];)c++;this.num=new Array(a.length-c+b);for(var d=0;d<a.length-c;d++)this.num[d]=a[d+c]}function j(a,b){this.totalCount=a,this.dataCount=b}function k(){this.buffer=[],this.length=0}function m(){return"undefined"!=typeof CanvasRenderingContext2D}function n(){var a=!1,b=navigator.userAgent;return/android/i.test(b)&&(a=!0,aMat=b.toString().match(/android ([0-9]\.[0-9])/i),aMat&&aMat[1]&&(a=parseFloat(aMat[1]))),a}function r(a,b){for(var c=1,e=s(a),f=0,g=l.length;g>=f;f++){var h=0;switch(b){case d.L:h=l[f][0];break;case d.M:h=l[f][1];break;case d.Q:h=l[f][2];break;case d.H:h=l[f][3]}if(h>=e)break;c++}if(c>l.length)throw new Error("Too long data");return c}function s(a){var b=encodeURI(a).toString().replace(/\%[0-9a-fA-F]{2}/g,"a");return b.length+(b.length!=a?3:0)}a.prototype={getLength:function(){return this.parsedData.length},write:function(a){for(var b=0,c=this.parsedData.length;c>b;b++)a.put(this.parsedData[b],8)}},b.prototype={addData:function(b){var c=new a(b);this.dataList.push(c),this.dataCache=null},isDark:function(a,b){if(0>a||this.moduleCount<=a||0>b||this.moduleCount<=b)throw new Error(a+","+b);return this.modules[a][b]},getModuleCount:function(){return this.moduleCount},make:function(){this.makeImpl(!1,this.getBestMaskPattern())},makeImpl:function(a,c){this.moduleCount=4*this.typeNumber+17,this.modules=new Array(this.moduleCount);for(var d=0;d<this.moduleCount;d++){this.modules[d]=new Array(this.moduleCount);for(var e=0;e<this.moduleCount;e++)this.modules[d][e]=null}this.setupPositionProbePattern(0,0),this.setupPositionProbePattern(this.moduleCount-7,0),this.setupPositionProbePattern(0,this.moduleCount-7),this.setupPositionAdjustPattern(),this.setupTimingPattern(),this.setupTypeInfo(a,c),this.typeNumber>=7&&this.setupTypeNumber(a),null==this.dataCache&&(this.dataCache=b.createData(this.typeNumber,this.errorCorrectLevel,this.dataList)),this.mapData(this.dataCache,c)},setupPositionProbePattern:function(a,b){for(var c=-1;7>=c;c++)if(!(-1>=a+c||this.moduleCount<=a+c))for(var d=-1;7>=d;d++)-1>=b+d||this.moduleCount<=b+d||(this.modules[a+c][b+d]=c>=0&&6>=c&&(0==d||6==d)||d>=0&&6>=d&&(0==c||6==c)||c>=2&&4>=c&&d>=2&&4>=d?!0:!1)},getBestMaskPattern:function(){for(var a=0,b=0,c=0;8>c;c++){this.makeImpl(!0,c);var d=f.getLostPoint(this);(0==c||a>d)&&(a=d,b=c)}return b},createMovieClip:function(a,b,c){var d=a.createEmptyMovieClip(b,c),e=1;this.make();for(var f=0;f<this.modules.length;f++)for(var g=f*e,h=0;h<this.modules[f].length;h++){var i=h*e,j=this.modules[f][h];j&&(d.beginFill(0,100),d.moveTo(i,g),d.lineTo(i+e,g),d.lineTo(i+e,g+e),d.lineTo(i,g+e),d.endFill())}return d},setupTimingPattern:function(){for(var a=8;a<this.moduleCount-8;a++)null==this.modules[a][6]&&(this.modules[a][6]=0==a%2);for(var b=8;b<this.moduleCount-8;b++)null==this.modules[6][b]&&(this.modules[6][b]=0==b%2)},setupPositionAdjustPattern:function(){for(var a=f.getPatternPosition(this.typeNumber),b=0;b<a.length;b++)for(var c=0;c<a.length;c++){var d=a[b],e=a[c];if(null==this.modules[d][e])for(var g=-2;2>=g;g++)for(var h=-2;2>=h;h++)this.modules[d+g][e+h]=-2==g||2==g||-2==h||2==h||0==g&&0==h?!0:!1}},setupTypeNumber:function(a){for(var b=f.getBCHTypeNumber(this.typeNumber),c=0;18>c;c++){var d=!a&&1==(1&b>>c);this.modules[Math.floor(c/3)][c%3+this.moduleCount-8-3]=d}for(var c=0;18>c;c++){var d=!a&&1==(1&b>>c);this.modules[c%3+this.moduleCount-8-3][Math.floor(c/3)]=d}},setupTypeInfo:function(a,b){for(var c=this.errorCorrectLevel<<3|b,d=f.getBCHTypeInfo(c),e=0;15>e;e++){var g=!a&&1==(1&d>>e);6>e?this.modules[e][8]=g:8>e?this.modules[e+1][8]=g:this.modules[this.moduleCount-15+e][8]=g}for(var e=0;15>e;e++){var g=!a&&1==(1&d>>e);8>e?this.modules[8][this.moduleCount-e-1]=g:9>e?this.modules[8][15-e-1+1]=g:this.modules[8][15-e-1]=g}this.modules[this.moduleCount-8][8]=!a},mapData:function(a,b){for(var c=-1,d=this.moduleCount-1,e=7,g=0,h=this.moduleCount-1;h>0;h-=2)for(6==h&&h--;;){for(var i=0;2>i;i++)if(null==this.modules[d][h-i]){var j=!1;g<a.length&&(j=1==(1&a[g]>>>e));var k=f.getMask(b,d,h-i);k&&(j=!j),this.modules[d][h-i]=j,e--,-1==e&&(g++,e=7)}if(d+=c,0>d||this.moduleCount<=d){d-=c,c=-c;break}}}},b.PAD0=236,b.PAD1=17,b.createData=function(a,c,d){for(var e=j.getRSBlocks(a,c),g=new k,h=0;h<d.length;h++){var i=d[h];g.put(i.mode,4),g.put(i.getLength(),f.getLengthInBits(i.mode,a)),i.write(g)}for(var l=0,h=0;h<e.length;h++)l+=e[h].dataCount;if(g.getLengthInBits()>8*l)throw new Error("code length overflow. ("+g.getLengthInBits()+">"+8*l+")");for(g.getLengthInBits()+4<=8*l&&g.put(0,4);0!=g.getLengthInBits()%8;)g.putBit(!1);for(;;){if(g.getLengthInBits()>=8*l)break;if(g.put(b.PAD0,8),g.getLengthInBits()>=8*l)break;g.put(b.PAD1,8)}return b.createBytes(g,e)},b.createBytes=function(a,b){for(var c=0,d=0,e=0,g=new Array(b.length),h=new Array(b.length),j=0;j<b.length;j++){var k=b[j].dataCount,l=b[j].totalCount-k;d=Math.max(d,k),e=Math.max(e,l),g[j]=new Array(k);for(var m=0;m<g[j].length;m++)g[j][m]=255&a.buffer[m+c];c+=k;var n=f.getErrorCorrectPolynomial(l),o=new i(g[j],n.getLength()-1),p=o.mod(n);h[j]=new Array(n.getLength()-1);for(var m=0;m<h[j].length;m++){var q=m+p.getLength()-h[j].length;h[j][m]=q>=0?p.get(q):0}}for(var r=0,m=0;m<b.length;m++)r+=b[m].totalCount;for(var s=new Array(r),t=0,m=0;d>m;m++)for(var j=0;j<b.length;j++)m<g[j].length&&(s[t++]=g[j][m]);for(var m=0;e>m;m++)for(var j=0;j<b.length;j++)m<h[j].length&&(s[t++]=h[j][m]);return s};for(var c={MODE_NUMBER:1,MODE_ALPHA_NUM:2,MODE_8BIT_BYTE:4,MODE_KANJI:8},d={L:1,M:0,Q:3,H:2},e={PATTERN000:0,PATTERN001:1,PATTERN010:2,PATTERN011:3,PATTERN100:4,PATTERN101:5,PATTERN110:6,PATTERN111:7},f={PATTERN_POSITION_TABLE:[ [],[6,18],[6,22],[6,26],[6,30],[6,34],[6,22,38],[6,24,42],[6,26,46],[6,28,50],[6,30,54],[6,32,58],[6,34,62],[6,26,46,66],[6,26,48,70],[6,26,50,74],[6,30,54,78],[6,30,56,82],[6,30,58,86],[6,34,62,90],[6,28,50,72,94],[6,26,50,74,98],[6,30,54,78,102],[6,28,54,80,106],[6,32,58,84,110],[6,30,58,86,114],[6,34,62,90,118],[6,26,50,74,98,122],[6,30,54,78,102,126],[6,26,52,78,104,130],[6,30,56,82,108,134],[6,34,60,86,112,138],[6,30,58,86,114,142],[6,34,62,90,118,146],[6,30,54,78,102,126,150],[6,24,50,76,102,128,154],[6,28,54,80,106,132,158],[6,32,58,84,110,136,162],[6,26,54,82,110,138,166],[6,30,58,86,114,142,170] ],G15:1335,G18:7973,G15_MASK:21522,getBCHTypeInfo:function(a){for(var b=a<<10;f.getBCHDigit(b)-f.getBCHDigit(f.G15)>=0;)b^=f.G15<<f.getBCHDigit(b)-f.getBCHDigit(f.G15);return(a<<10|b)^f.G15_MASK},getBCHTypeNumber:function(a){for(var b=a<<12;f.getBCHDigit(b)-f.getBCHDigit(f.G18)>=0;)b^=f.G18<<f.getBCHDigit(b)-f.getBCHDigit(f.G18);return a<<12|b},getBCHDigit:function(a){for(var b=0;0!=a;)b++,a>>>=1;return b},getPatternPosition:function(a){return f.PATTERN_POSITION_TABLE[a-1]},getMask:function(a,b,c){switch(a){case e.PATTERN000:return 0==(b+c)%2;case e.PATTERN001:return 0==b%2;case e.PATTERN010:return 0==c%3;case e.PATTERN011:return 0==(b+c)%3;case e.PATTERN100:return 0==(Math.floor(b/2)+Math.floor(c/3))%2;case e.PATTERN101:return 0==b*c%2+b*c%3;case e.PATTERN110:return 0==(b*c%2+b*c%3)%2;case e.PATTERN111:return 0==(b*c%3+(b+c)%2)%2;default:throw new Error("bad maskPattern:"+a)}},getErrorCorrectPolynomial:function(a){for(var b=new i([1],0),c=0;a>c;c++)b=b.multiply(new i([1,g.gexp(c)],0));return b},getLengthInBits:function(a,b){if(b>=1&&10>b)switch(a){case c.MODE_NUMBER:return 10;case c.MODE_ALPHA_NUM:return 9;case c.MODE_8BIT_BYTE:return 8;case c.MODE_KANJI:return 8;default:throw new Error("mode:"+a)}else if(27>b)switch(a){case c.MODE_NUMBER:return 12;case c.MODE_ALPHA_NUM:return 11;case c.MODE_8BIT_BYTE:return 16;case c.MODE_KANJI:return 10;default:throw new Error("mode:"+a)}else{if(!(41>b))throw new Error("type:"+b);switch(a){case c.MODE_NUMBER:return 14;case c.MODE_ALPHA_NUM:return 13;case c.MODE_8BIT_BYTE:return 16;case c.MODE_KANJI:return 12;default:throw new Error("mode:"+a)}}},getLostPoint:function(a){for(var b=a.getModuleCount(),c=0,d=0;b>d;d++)for(var e=0;b>e;e++){for(var f=0,g=a.isDark(d,e),h=-1;1>=h;h++)if(!(0>d+h||d+h>=b))for(var i=-1;1>=i;i++)0>e+i||e+i>=b||(0!=h||0!=i)&&g==a.isDark(d+h,e+i)&&f++;f>5&&(c+=3+f-5)}for(var d=0;b-1>d;d++)for(var e=0;b-1>e;e++){var j=0;a.isDark(d,e)&&j++,a.isDark(d+1,e)&&j++,a.isDark(d,e+1)&&j++,a.isDark(d+1,e+1)&&j++,(0==j||4==j)&&(c+=3)}for(var d=0;b>d;d++)for(var e=0;b-6>e;e++)a.isDark(d,e)&&!a.isDark(d,e+1)&&a.isDark(d,e+2)&&a.isDark(d,e+3)&&a.isDark(d,e+4)&&!a.isDark(d,e+5)&&a.isDark(d,e+6)&&(c+=40);for(var e=0;b>e;e++)for(var d=0;b-6>d;d++)a.isDark(d,e)&&!a.isDark(d+1,e)&&a.isDark(d+2,e)&&a.isDark(d+3,e)&&a.isDark(d+4,e)&&!a.isDark(d+5,e)&&a.isDark(d+6,e)&&(c+=40);for(var k=0,e=0;b>e;e++)for(var d=0;b>d;d++)a.isDark(d,e)&&k++;var l=Math.abs(100*k/b/b-50)/5;return c+=10*l}},g={glog:function(a){if(1>a)throw new Error("glog("+a+")");return g.LOG_TABLE[a]},gexp:function(a){for(;0>a;)a+=255;for(;a>=256;)a-=255;return g.EXP_TABLE[a]},EXP_TABLE:new Array(256),LOG_TABLE:new Array(256)},h=0;8>h;h++)g.EXP_TABLE[h]=1<<h;for(var h=8;256>h;h++)g.EXP_TABLE[h]=g.EXP_TABLE[h-4]^g.EXP_TABLE[h-5]^g.EXP_TABLE[h-6]^g.EXP_TABLE[h-8];for(var h=0;255>h;h++)g.LOG_TABLE[g.EXP_TABLE[h] ]=h;i.prototype={get:function(a){return this.num[a]},getLength:function(){return this.num.length},multiply:function(a){for(var b=new Array(this.getLength()+a.getLength()-1),c=0;c<this.getLength();c++)for(var d=0;d<a.getLength();d++)b[c+d]^=g.gexp(g.glog(this.get(c))+g.glog(a.get(d)));return new i(b,0)},mod:function(a){if(this.getLength()-a.getLength()<0)return this;for(var b=g.glog(this.get(0))-g.glog(a.get(0)),c=new Array(this.getLength()),d=0;d<this.getLength();d++)c[d]=this.get(d);for(var d=0;d<a.getLength();d++)c[d]^=g.gexp(g.glog(a.get(d))+b);return new i(c,0).mod(a)}},j.RS_BLOCK_TABLE=[ [1,26,19],[1,26,16],[1,26,13],[1,26,9],[1,44,34],[1,44,28],[1,44,22],[1,44,16],[1,70,55],[1,70,44],[2,35,17],[2,35,13],[1,100,80],[2,50,32],[2,50,24],[4,25,9],[1,134,108],[2,67,43],[2,33,15,2,34,16],[2,33,11,2,34,12],[2,86,68],[4,43,27],[4,43,19],[4,43,15],[2,98,78],[4,49,31],[2,32,14,4,33,15],[4,39,13,1,40,14],[2,121,97],[2,60,38,2,61,39],[4,40,18,2,41,19],[4,40,14,2,41,15],[2,146,116],[3,58,36,2,59,37],[4,36,16,4,37,17],[4,36,12,4,37,13],[2,86,68,2,87,69],[4,69,43,1,70,44],[6,43,19,2,44,20],[6,43,15,2,44,16],[4,101,81],[1,80,50,4,81,51],[4,50,22,4,51,23],[3,36,12,8,37,13],[2,116,92,2,117,93],[6,58,36,2,59,37],[4,46,20,6,47,21],[7,42,14,4,43,15],[4,133,107],[8,59,37,1,60,38],[8,44,20,4,45,21],[12,33,11,4,34,12],[3,145,115,1,146,116],[4,64,40,5,65,41],[11,36,16,5,37,17],[11,36,12,5,37,13],[5,109,87,1,110,88],[5,65,41,5,66,42],[5,54,24,7,55,25],[11,36,12],[5,122,98,1,123,99],[7,73,45,3,74,46],[15,43,19,2,44,20],[3,45,15,13,46,16],[1,135,107,5,136,108],[10,74,46,1,75,47],[1,50,22,15,51,23],[2,42,14,17,43,15],[5,150,120,1,151,121],[9,69,43,4,70,44],[17,50,22,1,51,23],[2,42,14,19,43,15],[3,141,113,4,142,114],[3,70,44,11,71,45],[17,47,21,4,48,22],[9,39,13,16,40,14],[3,135,107,5,136,108],[3,67,41,13,68,42],[15,54,24,5,55,25],[15,43,15,10,44,16],[4,144,116,4,145,117],[17,68,42],[17,50,22,6,51,23],[19,46,16,6,47,17],[2,139,111,7,140,112],[17,74,46],[7,54,24,16,55,25],[34,37,13],[4,151,121,5,152,122],[4,75,47,14,76,48],[11,54,24,14,55,25],[16,45,15,14,46,16],[6,147,117,4,148,118],[6,73,45,14,74,46],[11,54,24,16,55,25],[30,46,16,2,47,17],[8,132,106,4,133,107],[8,75,47,13,76,48],[7,54,24,22,55,25],[22,45,15,13,46,16],[10,142,114,2,143,115],[19,74,46,4,75,47],[28,50,22,6,51,23],[33,46,16,4,47,17],[8,152,122,4,153,123],[22,73,45,3,74,46],[8,53,23,26,54,24],[12,45,15,28,46,16],[3,147,117,10,148,118],[3,73,45,23,74,46],[4,54,24,31,55,25],[11,45,15,31,46,16],[7,146,116,7,147,117],[21,73,45,7,74,46],[1,53,23,37,54,24],[19,45,15,26,46,16],[5,145,115,10,146,116],[19,75,47,10,76,48],[15,54,24,25,55,25],[23,45,15,25,46,16],[13,145,115,3,146,116],[2,74,46,29,75,47],[42,54,24,1,55,25],[23,45,15,28,46,16],[17,145,115],[10,74,46,23,75,47],[10,54,24,35,55,25],[19,45,15,35,46,16],[17,145,115,1,146,116],[14,74,46,21,75,47],[29,54,24,19,55,25],[11,45,15,46,46,16],[13,145,115,6,146,116],[14,74,46,23,75,47],[44,54,24,7,55,25],[59,46,16,1,47,17],[12,151,121,7,152,122],[12,75,47,26,76,48],[39,54,24,14,55,25],[22,45,15,41,46,16],[6,151,121,14,152,122],[6,75,47,34,76,48],[46,54,24,10,55,25],[2,45,15,64,46,16],[17,152,122,4,153,123],[29,74,46,14,75,47],[49,54,24,10,55,25],[24,45,15,46,46,16],[4,152,122,18,153,123],[13,74,46,32,75,47],[48,54,24,14,55,25],[42,45,15,32,46,16],[20,147,117,4,148,118],[40,75,47,7,76,48],[43,54,24,22,55,25],[10,45,15,67,46,16],[19,148,118,6,149,119],[18,75,47,31,76,48],[34,54,24,34,55,25],[20,45,15,61,46,16] ],j.getRSBlocks=function(a,b){var c=j.getRsBlockTable(a,b);if(void 0==c)throw new Error("bad rs block @ typeNumber:"+a+"/errorCorrectLevel:"+b);for(var d=c.length/3,e=[],f=0;d>f;f++)for(var g=c[3*f+0],h=c[3*f+1],i=c[3*f+2],k=0;g>k;k++)e.push(new j(h,i));return e},j.getRsBlockTable=function(a,b){switch(b){case d.L:return j.RS_BLOCK_TABLE[4*(a-1)+0];case d.M:return j.RS_BLOCK_TABLE[4*(a-1)+1];case d.Q:return j.RS_BLOCK_TABLE[4*(a-1)+2];case d.H:return j.RS_BLOCK_TABLE[4*(a-1)+3];default:return void 0}},k.prototype={get:function(a){var b=Math.floor(a/8);return 1==(1&this.buffer[b]>>>7-a%8)},put:function(a,b){for(var c=0;b>c;c++)this.putBit(1==(1&a>>>b-c-1))},getLengthInBits:function(){return this.length},putBit:function(a){var b=Math.floor(this.length/8);this.buffer.length<=b&&this.buffer.push(0),a&&(this.buffer[b]|=128>>>this.length%8),this.length++}};var l=[ [17,14,11,7],[32,26,20,14],[53,42,32,24],[78,62,46,34],[106,84,60,44],[134,106,74,58],[154,122,86,64],[192,152,108,84],[230,180,130,98],[271,213,151,119],[321,251,177,137],[367,287,203,155],[425,331,241,177],[458,362,258,194],[520,412,292,220],[586,450,322,250],[644,504,364,280],[718,560,394,310],[792,624,442,338],[858,666,482,382],[929,711,509,403],[1003,779,565,439],[1091,857,611,461],[1171,911,661,511],[1273,997,715,535],[1367,1059,751,593],[1465,1125,805,625],[1528,1190,868,658],[1628,1264,908,698],[1732,1370,982,742],[1840,1452,1030,790],[1952,1538,1112,842],[2068,1628,1168,898],[2188,1722,1228,958],[2303,1809,1283,983],[2431,1911,1351,1051],[2563,1989,1423,1093],[2699,2099,1499,1139],[2809,2213,1579,1219],[2953,2331,1663,1273] ],o=function(){var a=function(a,b){this._el=a,this._htOption=b};return a.prototype.draw=function(a){function g(a,b){var c=document.createElementNS("http://www.w3.org/2000/svg",a);for(var d in b)b.hasOwnProperty(d)&&c.setAttribute(d,b[d]);return c}var b=this._htOption,c=this._el,d=a.getModuleCount();Math.floor(b.width/d),Math.floor(b.height/d),this.clear();var h=g("svg",{viewBox:"0 0 "+String(d)+" "+String(d),width:"100%",height:"100%",fill:b.colorLight});h.setAttributeNS("http://www.w3.org/2000/xmlns/","xmlns:xlink","http://www.w3.org/1999/xlink"),c.appendChild(h),h.appendChild(g("rect",{fill:b.colorDark,width:"1",height:"1",id:"template"}));for(var i=0;d>i;i++)for(var j=0;d>j;j++)if(a.isDark(i,j)){var k=g("use",{x:String(i),y:String(j)});k.setAttributeNS("http://www.w3.org/1999/xlink","href","#template"),h.appendChild(k)}},a.prototype.clear=function(){for(;this._el.hasChildNodes();)this._el.removeChild(this._el.lastChild)},a}(),p="svg"===document.documentElement.tagName.toLowerCase(),q=p?o:m()?function(){function a(){this._elImage.src=this._elCanvas.toDataURL("image/png"),this._elImage.style.display="block",this._elCanvas.style.display="none"}function d(a,b){var c=this;if(c._fFail=b,c._fSuccess=a,null===c._bSupportDataURI){var d=document.createElement("img"),e=function(){c._bSupportDataURI=!1,c._fFail&&_fFail.call(c)},f=function(){c._bSupportDataURI=!0,c._fSuccess&&c._fSuccess.call(c)};return d.onabort=e,d.onerror=e,d.onload=f,d.src="data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",void 0}c._bSupportDataURI===!0&&c._fSuccess?c._fSuccess.call(c):c._bSupportDataURI===!1&&c._fFail&&c._fFail.call(c)}if(this._android&&this._android<=2.1){var b=1/window.devicePixelRatio,c=CanvasRenderingContext2D.prototype.drawImage;CanvasRenderingContext2D.prototype.drawImage=function(a,d,e,f,g,h,i,j){if("nodeName"in a&&/img/i.test(a.nodeName))for(var l=arguments.length-1;l>=1;l--)arguments[l]=arguments[l]*b;else"undefined"==typeof j&&(arguments[1]*=b,arguments[2]*=b,arguments[3]*=b,arguments[4]*=b);c.apply(this,arguments)}}var e=function(a,b){this._bIsPainted=!1,this._android=n(),this._htOption=b,this._elCanvas=document.createElement("canvas"),this._elCanvas.width=b.width,this._elCanvas.height=b.height,a.appendChild(this._elCanvas),this._el=a,this._oContext=this._elCanvas.getContext("2d"),this._bIsPainted=!1,this._elImage=document.createElement("img"),this._elImage.style.display="none",this._el.appendChild(this._elImage),this._bSupportDataURI=null};return e.prototype.draw=function(a){var b=this._elImage,c=this._oContext,d=this._htOption,e=a.getModuleCount(),f=d.width/e,g=d.height/e,h=Math.round(f),i=Math.round(g);b.style.display="none",this.clear();for(var j=0;e>j;j++)for(var k=0;e>k;k++){var l=a.isDark(j,k),m=k*f,n=j*g;c.strokeStyle=l?d.colorDark:d.colorLight,c.lineWidth=1,c.fillStyle=l?d.colorDark:d.colorLight,c.fillRect(m,n,f,g),c.strokeRect(Math.floor(m)+.5,Math.floor(n)+.5,h,i),c.strokeRect(Math.ceil(m)-.5,Math.ceil(n)-.5,h,i)}this._bIsPainted=!0},e.prototype.makeImage=function(){this._bIsPainted&&d.call(this,a)},e.prototype.isPainted=function(){return this._bIsPainted},e.prototype.clear=function(){this._oContext.clearRect(0,0,this._elCanvas.width,this._elCanvas.height),this._bIsPainted=!1},e.prototype.round=function(a){return a?Math.floor(1e3*a)/1e3:a},e}():function(){var a=function(a,b){this._el=a,this._htOption=b};return a.prototype.draw=function(a){for(var b=this._htOption,c=this._el,d=a.getModuleCount(),e=Math.floor(b.width/d),f=Math.floor(b.height/d),g=['<table style="border:0;border-collapse:collapse;">'],h=0;d>h;h++){g.push("<tr>");for(var i=0;d>i;i++)g.push('<td style="border:0;border-collapse:collapse;padding:0;margin:0;width:'+e+"px;height:"+f+"px;background-color:"+(a.isDark(h,i)?b.colorDark:b.colorLight)+';"></td>');g.push("</tr>")}g.push("</table>"),c.innerHTML=g.join("");var j=c.childNodes[0],k=(b.width-j.offsetWidth)/2,l=(b.height-j.offsetHeight)/2;k>0&&l>0&&(j.style.margin=l+"px "+k+"px")},a.prototype.clear=function(){this._el.innerHTML=""},a}();QRCode=function(a,b){if(this._htOption={width:256,height:256,typeNumber:4,colorDark:"#000000",colorLight:"#ffffff",correctLevel:d.H},"string"==typeof b&&(b={text:b}),b)for(var c in b)this._htOption[c]=b[c];"string"==typeof a&&(a=document.getElementById(a)),this._android=n(),this._el=a,this._oQRCode=null,this._oDrawing=new q(this._el,this._htOption),this._htOption.text&&this.makeCode(this._htOption.text)},QRCode.prototype.makeCode=function(a){this._oQRCode=new b(r(a,this._htOption.correctLevel),this._htOption.correctLevel),this._oQRCode.addData(a),this._oQRCode.make(),this._el.title=a,this._oDrawing.draw(this._oQRCode),this.makeImage()},QRCode.prototype.makeImage=function(){"function"==typeof this._oDrawing.makeImage&&(!this._android||this._android>=3)&&this._oDrawing.makeImage()},QRCode.prototype.clear=function(){this._oDrawing.clear()},QRCode.CorrectLevel=d}();

    </script>
    <style>
        body {
            font-size: 20px;
            margin: 0;
            padding: 0;
            background: #000;
            color: white;
            font-family: sans-serif;
        }

        #main {
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        .content {
            flex: 1;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 200px;
            overflow-y: auto;
            background-color: #1a1a1d;
            border-radius: 0px 0px 20px 20px;
        }

        .button {
            background-color: #4b4f50;
            border: none;
            color: white;
            padding: 18px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 20px;
            font-weight: bold;
            margin: 10px;
            cursor: pointer;
            border-radius: 5px;
            position: relative;
            min-width: 180px;
        }

        .button:hover {
            background-color: #3e4344;
        }

        .button.active {
            background-color: #496485;
            cursor: not-allowed;
            opacity: 0.7;
        }

        .button-text {
            transition: opacity 0.3s;
        }

        .log-container {
            background: #000;
            color: #fff;
            text-align: left;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            align-items: flex-start;
            padding: 10px;
            height: 200px;
            overflow: hidden;
            font-family: monospace;
            font-size: 16px;
            border: 0;
            width: 100%;
            box-sizing: border-box;
            transition: all 0.5s ease;
            position: relative;
            cursor: pointer;
            bottom: 0;
        }

        .log-entry {
            margin: 2px 0;
            word-wrap: break-word;
        }

        #log-content {
            transition: all 0.5s ease;
            width: 100%;
        }

        .fullscreen-log #log-content {
            overflow-y: scroll;
        }

        .fullscreen-log .content {
            display: none;
        }
        
        .fullscreen-log .log-container {
            height: 100%;
            position: fixed;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: 1002;
        }
        .return-message {
            display: none;
        }

        .fullscreen-log .return-message {
            display: block;
            left: 50%;
            transform: translateX(-50%);
            position: fixed;
            top: 6px;
            background-color: #00000040;
            border-radius: 6px;
            text-align: center;
            font-size: 24px;
            z-index: 1003;
        }
        .return-message p {
            margin: 0;
            padding: 0;
        }

        .payloads-section {
            width: 100%;
            max-width: 1200px;
            margin-top: 20px;
        }
        
        .section-title {
            color: #b5b5b5;
            padding: 10px;
            border-radius: 5px 5px 0 0;
            margin-top: 10px;
            text-align: center;
        }

        .payload-path-tag {
            position: absolute;
            top: 2px;
            left: 2px;
            background-color: #4e5f6d;
            color: #c6c6c6;
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 14px;
            font-weight: bold;
            z-index: 1;
        }

        .manage-button {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: #4e79ae;
            border: none;
            color: white;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 5px;
            z-index: 10;
        }

        .manage-button:hover {
            background-color: #416796;
        }

        .overlay {
            display: none;
            opacity: 0%;
            position: fixed;
            top: 0;
            left: 100%;
            width: 100%;
            height: 100%;
            background-color: #1a1a1d;
            z-index: 1000;
            overflow: auto;
            color: white;
            padding: 40px 20px;
            box-sizing: border-box;
            transition: opacity 0.5s ease, left 0.5s ease;
        }

        .overlay-content {
            max-width: 1100px;
            margin: 0 auto;
            text-align: center;
        }

        .info-section h3 {
            margin-top: 0;
            color: #1f83ff;
        }

        .qr-container {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .error-message {
            color: #ff5555;
            font-weight: bold;
        }

        .close-button {
            background-color: #4e79ae;
            border: none;
            color: white;
            padding: 12px 30px;
            text-align: center;
            text-decoration: none;
            font-size: 26px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
        }

        .close-button:hover {
            background-color: #416796;
        }
        .qr-container {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }
        
        .info-section {
            text-align: left;
            margin: 20px 0;
            padding: 16px 48px;
            background-color: #292b2e;
            border-radius: 5px;
        }
        
        .info-section h3 {
            margin-top: 0;
            color: #fff;
        }
        
        .error-message {
            color: #ff5555;
            font-weight: bold;
        }

        /* Two-column layout for QR and description */
        .two-column-layout {
            display: flex;
            flex-direction: row;
            align-items: center;
            margin: 20px 0;
        }

        .description-column {
            flex: 1;
            padding-right: 20px;
        }

        .qr-column {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .exit-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #6d2f2f;
            border: none;
            color: white;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            font-size: 32px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 5px;
            z-index: 1001;
            display: none;
        }

        .exit-button:hover {
            background-color: #562929;
        }

        #busy {
            background-color: rgba(0, 0, 0, 0.7);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1010;
            text-align: center;
        }

        #busy.hidden {
            display: none;
        }
        
        .loading-spinner {
            border: 6px solid #555;
            border-top: 6px solid #007acc;
            border-radius: 50%;
            width: 48px;
            height: 48px;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

    </style>
</head>
<body>

<button id="exitBtn" class="exit-button">EXIT</button>

<div id="payloadOverlay" class="overlay">
    <div class="overlay-content">
        <div class="info-section">
            <h3>Manage Payloads</h3>
            <div class="two-column-layout">
                <div class="description-column">
                    <p id="ipAddressInfo">Loading IP address information...</p>
                </div>
                <div class="qr-column">
                    <div id="qrCode"></div>
                </div>
            </div>
        </div>
                
        <div class="info-section">
            <p>You can also manually add payloads by placing .elf/.bin/.lua files in these locations:</p>
            <ul>
                <li>Internal storage: <code>/data/ps5_lua_loader</code></li>
                <li>USB storage: <code>USB/ps5_lua_loader/</code></li>
            </ul>
        </div>
        
        <button id="closeOverlay" class="close-button">Continue</button>
    </div>
</div>
    
<div id="main">

    <button id="managePayloadsBtn" class="manage-button">Manage Payloads</button>

    <div class="content">

        <div class="payloads-section">
            <div id="payloads-container">
                <div style="text-align: center; padding: 20px;">Loading payloads...</div>
            </div>
        </div>
    </div>
    <button class="log-container" id="log-container" onclick="toggleFullscreenLog()">
        <pre id="log-content"></pre>
    </button>
    <div class="return-message">
        <p>Press <span style="background-color: #ccc; color: #000; font-weight: bold; border-radius: 16px; padding: 0px 6px; font-size: 18px;">X</span> to return...</p>
    </div>
</div>


<div id="busy">
    <div class="loading-spinner" style="margin: auto; display: block; margin-top: calc(50vh - 133px);"></div>
</div>

    <script>
        const menuVersion = "";
        const logContainer = document.getElementById('log-container');
        const logContent = document.getElementById('log-content');
        let isFullscreenLog = false;
        let isLogHidden = false;
        let autoScrollEnabled = true;
        let lastLogCount = 0;

        // Fetch payloads and create buttons
        function fetchPayloads() {
            fetch('/list_payloads')
                .then(response => response.json())
                .then(data => {
                    const payloadsContainer = document.getElementById('payloads-container');
                    payloadsContainer.innerHTML = ''; // Clear loading message
                    
                    if (data.payloads && data.payloads.length > 0) {
                        data.payloads.forEach(path => {
                            // Create a button for each payload
                            const button = document.createElement('button');
                            button.className = 'button';

                            // Extract filename from path for shorter display
                            const fileName = path.split('/').pop();
                            
                            let name = fileName;
                            if (name.toLowerCase().endsWith('.bin') || name.toLowerCase().endsWith('.elf')) {
                                name = name.slice(0, name.lastIndexOf('.'));
                                name = name.replace(/_/g, ' ');
                            }

                            // Create span for button text
                            const span = document.createElement('span');
                            span.className = 'button-text';
                            span.textContent = name;
                            
                            button.appendChild(span);
                            
                            // Create tag
                            const tag = document.createElement('span');
                            tag.className = 'payload-path-tag';
                            let tagText = '';
                            let tagClass = '';
                            
                            if (path.startsWith('/data/')) {
                                //tagText = '/data';
                                //tagClass = 'payload-path-data';
                            } else if (path.startsWith('/mnt/usb')) {
                                const usbNumber = path.substring(8,9); // Extract number after /mnt/usb
                                tagText = 'USB'; //+ usbNumber;
                                tagClass = 'payload-path-usb';
                            }
                            if (tagText) {
                                tag.textContent = tagText;
                                tag.classList.add(tagClass);
                                button.appendChild(tag);
                            }
                            // Add click handler to load the payload
                            button.onclick = function() {
                                loadPayload(path, this);
                            };
                            
                            payloadsContainer.appendChild(button);
                        });
                    } else {
                        payloadsContainer.innerHTML = '<div style="text-align: center; padding: 20px;">No payloads found</div>';
                    }
                })
                .catch(error => {
                    console.error('Error fetching payloads:', error);
                    const payloadsContainer = document.getElementById('payloads-container');
                    payloadsContainer.innerHTML = '<div style="text-align: center; padding: 20px; color: #FF5555;">Error loading payloads</div>';
                });
        }
        
        // Function to load a payload
        function loadPayload(path, buttonElement) {
            buttonElement.classList.add("active");
            document.getElementById("busy").classList.remove("hidden");
            
            const fileName = path.split('/').pop();
            
            // Send the command to load the payload
            fetch('/loadpayload:' + encodeURIComponent(path))
                .then(response => response.text())
                .then(data => {
                    console.log('Payload load response:', data);
                })
                .catch(error => {
                    console.error('Payload load error:', error);
                })
                .finally(() => {
                    buttonElement.classList.remove("active");
                    document.getElementById("busy").classList.add("hidden");
                });
        }

        function toggleFullscreenLog() {
            isFullscreenLog = !isFullscreenLog;
            document.body.classList.toggle('fullscreen-log', isFullscreenLog);
            if (!isFullscreenLog) {
                scrollToBottom();
            }
        }
        function fetchLogs() {
            fetch('/log')
                .then(response => response.json())
                .then(data => {
                    // Only update if auto-scroll is enabled or we have new logs
                    if (autoScrollEnabled || data.logs.length !== lastLogCount) {
                        updateLogDisplay(data.logs);
                        lastLogCount = data.logs.length;
                    }
                })
                .catch(error => {
                    console.error('Error fetching logs:', error);
                })
                .finally(() => {
                    setTimeout(fetchLogs, 1000);
                });
        }
        
        function updateLogDisplay(logs) {
            // Update the log content
            logContent.innerHTML = '';
            logs.forEach(log => {
                const logEntry = document.createElement('div');
                logEntry.className = 'log-entry';
                logEntry.textContent = log;
                logContent.appendChild(logEntry);
            });
            
            // Only scroll to bottom if auto-scroll is enabled
            if (autoScrollEnabled) {
                scrollToBottom();
            }
        }
        
        function scrollToBottom() {
            logContent.scrollTop = logContent.scrollHeight;
            autoScrollEnabled = true;
        }
        
        function isScrolledToBottom() {
            return logContent.scrollHeight - logContent.clientHeight <= logContent.scrollTop + 5;
        }
        
        // Check scroll position
        logContent.addEventListener('scroll', function() {
            if (!isScrolledToBottom()) {
                autoScrollEnabled = false;
            } else {
                autoScrollEnabled = true;
            }
        });
        
        // Start fetching logs
        fetchLogs();
        
        // Fetch payloads when page loads
        fetchPayloads();

        // Send keepalive every 2 seconds
        function keepAliveLoop() {
            setInterval(function() {
                fetch('/keepalive')
                .then(response => {
                    document.getElementById("busy").classList.add("hidden");
                })
                .catch(error => {
                    document.getElementById("busy").classList.remove("hidden");
                    console.error("Keepalive failed:", error)
                });
            }, 2000);
        }
        
        window.addEventListener('load', keepAliveLoop);

        let overlay = document.getElementById("payloadOverlay");
        let manageBtn = document.getElementById("managePayloadsBtn");
        let closeOverlayBtn = document.getElementById("closeOverlay");

        let main = document.getElementById("main");

        // Open overlay when button is clicked
        manageBtn.onclick = function() {
            overlay.style.display = "block";
            setTimeout(function() {
                overlay.style.left = "0%";
                overlay.style.opacity = "100%";
            }, 0);
            setTimeout(function() {
                main.style.display = "none";
            }, 500);
            getIPAddress();
        }

        // Close overlay when button is clicked
        closeOverlayBtn.onclick = function() {
            overlay.style.left = "100%";
            overlay.style.opacity = "0%";

            setTimeout(function() {
                overlay.style.display = "none";
            }, 500);
            main.style.display = "flex";
            fetchPayloads();
        }

        // Function to get the IP address and generate QR code
        function getIPAddress() {
            fetch('/getip')
                .then(response => response.text())
                .then(data => {
                    const ipAddressInfo = document.getElementById('ipAddressInfo');
                    const qrContainer = document.getElementById('qrCode');
                    
                    // Clear previous content
                    qrContainer.innerHTML = '';
                    
                    if (data === 'error') {
                        ipAddressInfo.innerHTML = '<span class="error-message">Could not retrieve local IP address. Please check your network connection.</span>';
                    } else {
                        // Get the current port from the URL
                        const currentPort = window.location.port || (window.location.protocol === 'https:' ? '443' : '80');
                        const fullAddress = `http://${data}:${currentPort}`;
                        
                        ipAddressInfo.innerHTML = `
                            <p>To manage payloads remotely, open this address in a browser:</p>
                            <h2><strong>${fullAddress}</strong></h2>
                        `;
                        
                        // Generate QR code
                        try {
                            new QRCode(qrContainer, {
                                text: fullAddress,
                                width: 200,
                                height: 200,
                                colorDark: "#ffffff",
                                colorLight: "#292b2e",
                                correctLevel: QRCode.CorrectLevel.H
                            });
                        } catch (e) {
                            console.error('Error generating QR code:', e);
                            ipAddressInfo.innerHTML += '<span class="error-message">Failed to generate QR code.</span>';
                        }
                    }
                })
                .catch(error => {
                    console.error('Error fetching IP address:', error);
                    document.getElementById('ipAddressInfo').innerHTML = 
                        '<span class="error-message">Failed to retrieve IP address information. Please try again later.</span>';
                });
        }

        if (navigator.userAgent.includes("PlayStation")) {
            // it's a PS5
        } else {
            // redirect to management page
            window.location.href = "/manage";
        }

        function getVersion() {
            fetch('/version')
                .then(response => response.text())
                .then(data => {
                    if (data === 'error') {
                        console.log('Error fetching menu version');
                    } else {
                        document.title = document.title + " v" + data;
                    }
                })
                .catch(error => {
                    console.error('Error fetching menu version:', error);
                });
        }
        getVersion();

        document.getElementById('exitBtn').addEventListener('click', function() {
            fetch('/shutdown')
                .then(response => {
                    console.log('Shutdown request sent');
                    
                    document.body.innerHTML = '<div style="display: flex; justify-content: center; align-items: center; height: 100vh;"><h1>You can now close this window</h1></div>';
                    document.body.style.backgroundColor = 'black';
                    document.body.style.color = 'lightgrey';
                    document.documentElement.style.height = '100%';
                    document.body.style.height = '100%';
                    document.body.style.margin = '0';
                    document.body.style.padding = '0';
                })
                .catch(error => {
                    console.error('Error sending shutdown request:', error);
                });
        });

        document.getElementById("busy").classList.add("hidden");
        
    </script>
</body>
</html>
]]
local HTML_MANAGE_CONTENT = [[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payload Manager - PLK's Lua Menu</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            margin: 0;
            padding: 20px;
            background-color: #1e1e1e;
            color: #e0e0e0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #2c2c2c;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.5);
            padding: 20px;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            color: #9e9e9e;
            font-size: 14px;
        }
        .footer a {
            color: #6a8fa7;
            text-decoration: underline;
        }
        h1 {
            text-align: center;
            color: #e0e0e0;
            margin-bottom: 0;
        }
        h2 {
            text-align: center;
            color: #ccc;
            margin-top: 0;
        }

        .file-list {
            list-style: none;
            padding: 0;
            margin: 36px 0;
        }
        .file-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 15px;
            background-color: #3a3a3a;
            margin-bottom: 8px;
            border-radius: 4px;
            border-left: 4px solid #007acc;
        }
        .file-name {
            word-break: break-all;
            padding-right: 10px;
        }
        .delete-btn {
            background-color: #d32f2f;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .delete-btn:hover {
            background-color: #b71c1c;
        }
        .upload-section {
            margin-top: 30px;
            text-align: center;
        }
        .upload-btn {
            background-color: #4caf50;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .upload-btn:hover {
            background-color: #388e3c;
        }
        .browse-btn {
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-left: 10px;
        }
        .browse-btn:hover {
            background-color: #1976d2;
        }
        .file-input {
            display: none;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        #uploadModal {
            z-index: 1001;
        }
        .modal-content {
            background-color: #333333;
            padding: 20px;
            border-radius: 8px;
            color: #e0e0e0;
            max-width: 90%;
            width: 400px;
            text-align: center;
        }
        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }
        .modal-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .confirm-btn {
            background-color: #d32f2f;
            color: white;
        }
        .cancel-btn {
            background-color: #546e7a;
            color: white;
        }
        .loading-spinner {
            border: 4px solid #555;
            border-top: 4px solid #007acc;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 0.8s linear infinite;
            margin: 10px auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .no-files {
            text-align: center;
            padding: 20px;
            color: #9e9e9e;
            font-style: italic;
        }
        .error-message {
            color: #ef5350;
            margin-top: 10px;
            text-align: center;
        }
        .browse-modal-list {
            list-style: none;
            padding: 0;
            margin: 0;
            max-height: calc(80vh - 100px);
            overflow-y: auto;
        }
        .browse-modal-item {
            padding: 10px;
            border-bottom: 1px solid #555;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .browse-modal-item:last-child {
            border-bottom: none;
        }
        .browse-modal-item p {
            margin: 5px 0;
            text-align: left;
        }
        .browse-modal-download {
            background-color: #4caf50;
            color: #fff;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            display: flex;
            align-items: center;
        }
        .browse-modal-download:hover {
            background-color: #388e3c;
        }
        #browseModal .modal-content {
            width: 600px;
            max-width: 95%;
        }
        .browse-payload-description {
            font-size: 12px;
            color: #999;
            margin: 0;
        }
        .browse-payload-description a {
            color: #6a8fa7;
            text-decoration: underline;
        }
        #browseLoadingSpinner {
            margin: 20px auto;
            display: none;
        }
        #browseErrorMessage {
            color: #ef5350;
            text-align: center;
            margin-top: 20px;
            display: none;
        }
        .browse-error-message {
            color: #fff;
            background-color: #bf1515;
            padding: 5px 10px;
            border-radius: 4px;
            font-weight: bold;
            display: none;
        }
        .download-spinner {
            border: 3px solid #fff;
            border-top: 3px solid transparent;
            border-radius: 50%;
            width: 16px;
            height: 16px;
            animation: spin 0.6s linear infinite;
            margin-left: 5px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Payload Manager</h1>
        
        <ul id="fileList" class="file-list">
            <li class="no-files">Loading files...</li>
        </ul>
        
        <div class="upload-section">
            <input type="file" id="fileInput" class="file-input" accept=".elf,.bin,.lua">
            <button id="uploadBtn" class="upload-btn">Upload File</button>
            <button id="browseBtn" class="browse-btn">Browse Payloads</button>
            <p id="fileTypeError" class="error-message" style="display:none;">Please select a .elf, .bin, or .lua file.</p>
        </div>
    </div>

    <div class="footer">
        <p>PLK's Lua Menu <span class="menu-version"></span> | Source on <a href="https://github.com/itsPLK/ps5_lua_menu" target="_blank">GitHub</a></p>
    </div>
    
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h3>Confirm Deletion</h3>
            <p>Are you sure you want to delete <span id="fileToDelete"></span>?</p>
            <div class="modal-buttons">
                <button id="cancelDelete" class="modal-btn cancel-btn">Cancel</button>
                <button id="confirmDelete" class="modal-btn confirm-btn">Delete</button>
            </div>
        </div>
    </div>
    
    <div id="uploadModal" class="modal">
        <div class="modal-content">
            <h3 id="uploadStatus">Adding File</h3>
            <div id="uploadSpinner" class="loading-spinner"></div>
            <p id="uploadMessage">Please wait while your file is being uploaded...</p>
            <div class="modal-buttons">
                <button id="closeUpload" class="modal-btn cancel-btn" style="display: none;">Close</button>
            </div>
        </div>
    </div>

    <div id="browseModal" class="modal">
        <div class="modal-content">
            <h3>Available Payloads</h3>
            <div id="browseLoadingSpinner" class="loading-spinner"></div>
            <p id="browseErrorMessage" class="error-message"></p>
            <ul id="browseModalList" class="browse-modal-list">
            </ul>
            <a href="https://github.com/itsPLK/ps5_payloads/issues" target="_blank" style="color: #6a8fa7; text-decoration: underline;">Suggest a payload to be added to the list</a>
            <div class="modal-buttons">
                <button id="closeBrowse" class="modal-btn cancel-btn">Close</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const fileList = document.getElementById('fileList');
            const uploadBtn = document.getElementById('uploadBtn');
            const fileInput = document.getElementById('fileInput');
            const deleteModal = document.getElementById('deleteModal');
            const uploadModal = document.getElementById('uploadModal');
            const fileToDelete = document.getElementById('fileToDelete');
            const confirmDelete = document.getElementById('confirmDelete');
            const cancelDelete = document.getElementById('cancelDelete');
            const closeUpload = document.getElementById('closeUpload');
            const uploadStatus = document.getElementById('uploadStatus');
            const uploadMessage = document.getElementById('uploadMessage');
            const uploadSpinner = document.getElementById('uploadSpinner');
            const fileTypeError = document.getElementById('fileTypeError');
            const browseBtn = document.getElementById('browseBtn');
            const browseModal = document.getElementById('browseModal');
            const browseModalList = document.getElementById('browseModalList');
            const closeBrowse = document.getElementById('closeBrowse');
            const browseLoadingSpinner = document.getElementById('browseLoadingSpinner');
            const browseErrorMessage = document.getElementById('browseErrorMessage');

            let currentFilePath = '';
            const payloadsUrl = 'https://itsplk.github.io/ps5_payloads/ps5_payloads.json';
            
            fetchPayloads();
            
            setInterval(fetchPayloads, 10000);
            uploadBtn.addEventListener('click', function() {
                fileInput.click();
            });
            
            fileInput.addEventListener('change', function(e) {
                if (fileInput.files.length > 0) {
                    const file = fileInput.files[0];
                    const fileName = file.name.toLowerCase();
                    if (fileName.endsWith('.elf') || fileName.endsWith('.bin') || fileName.endsWith('.lua')) {
                        fileTypeError.style.display = 'none';
                    uploadFile(file);
                    } else {
                        fileTypeError.style.display = 'block';
                    }
                }
            });
            
            cancelDelete.addEventListener('click', function() {
                deleteModal.style.display = 'none';
                currentFilePath = '';
            });
            
            confirmDelete.addEventListener('click', function() {
                if (currentFilePath) {
                    deleteFile(currentFilePath);
                }
            });
            
            closeUpload.addEventListener('click', function() {
                uploadModal.style.display = 'none';
                uploadSpinner.style.display = 'block';
                closeUpload.style.display = 'none';
            });
            
            browseBtn.addEventListener('click', function() {
                browseModalList.innerHTML = '';
                browseErrorMessage.style.display = 'none';
                browseLoadingSpinner.style.display = 'block';
                browseModal.style.display = 'flex';
                fetch(payloadsUrl)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json();
                    })
                    .then(payloads => {
                        browseLoadingSpinner.style.display = 'none';
                        displayBrowseList(payloads);
                    })
                .catch(error => {
                        browseLoadingSpinner.style.display = 'none';
                        browseErrorMessage.textContent = `Error loading payloads: ${error.message}`;
                        browseErrorMessage.style.display = 'block';
                    });
            });

            closeBrowse.addEventListener('click', function() {
                browseModal.style.display = 'none';
            });
            function fetchPayloads() {
                fetch('/list_payloads:only_data')
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json();
                    })
                    .then(data => {
                        displayFiles(data.payloads);
                    })
                    .catch(error => {
                        fileList.innerHTML = `<p class="no-files">Error loading files: ${error.message}</li>`;
                    });
            }
            
            function displayFiles(files) {
                if (!files || files.length === 0) {
                    fileList.innerHTML = '<li class="no-files">No files found</li>';
                    return;
                }
                
                fileList.innerHTML = '';
                
                files.forEach(filePath => {
                    const fileName = filePath.split('/').pop();
                    
                    const li = document.createElement('li');
                    li.className = 'file-item';
                    
                    const fileNameSpan = document.createElement('span');
                    fileNameSpan.className = 'file-name';
                    fileNameSpan.textContent = fileName;
                    
                    const deleteBtn = document.createElement('button');
                    deleteBtn.className = 'delete-btn';
                    deleteBtn.textContent = 'Delete';
                    deleteBtn.addEventListener('click', function() {
                        showDeleteConfirmation(filePath, fileName);
                    });
                    
                    li.appendChild(fileNameSpan);
                    li.appendChild(deleteBtn);
                    fileList.appendChild(li);
                });
            }
            
            function displayBrowseList(payloads) {
                browseModalList.innerHTML = '';
                payloads.forEach(payload => {
                    const li = document.createElement('li');
                    li.className = 'browse-modal-item';
                            let name = payload.filename;
                            if (name.toLowerCase().endsWith('.bin') || name.toLowerCase().endsWith('.elf')) {
                                name = name.slice(0, name.lastIndexOf('.'));
                                name = name.replace(/_/g, ' ');
                            }
                    li.innerHTML = `
                        <div>
                            <p><strong>${name}</strong></p>
                            <p class="browse-payload-description">${payload.description}</p>
                            <p class="browse-payload-description">Last Update: ${payload.last_update}, <a href="${payload.source}" target="_blank">Source</a></p>
                            <p class="browse-error-message"></p>
                        </div>
                        <button class="browse-modal-download" data-url="${payload.url}" data-filename="${payload.filename}">Download <span class="download-spinner"></span></button>
                    `;
                    browseModalList.appendChild(li);
                });
            }
    
            browseModalList.addEventListener('click', function(event) {
                if (event.target.classList.contains('browse-modal-download')) {
                    const button = event.target;
                    const url = button.dataset.url;
                    const filename = button.dataset.filename;
                    const spinner = button.querySelector('.download-spinner');
                    spinner.style.display = 'inline-block';

                    downloadAndUpload(url, filename, button, spinner);
                }
            });

            function downloadAndUpload(url, filename, button, spinner) {
                        const listItem = Array.from(browseModalList.children).find(item => item.querySelector('.browse-modal-download').dataset.filename === filename);
                        let errorDisplay;
                        if (listItem) {
                            errorDisplay = listItem.querySelector('.browse-error-message');
                            errorDisplay.style.display = 'none';
                    }

                        fetch(url)
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error(`Failed to download file: ${response.status}`);
                                }
                                return response.blob();
                    })
                            .then(blob => {
                                const file = new File([blob], filename);
                                uploadFile(file);
                            })
                            .catch(error => {
                                if (errorDisplay) {
                                    errorDisplay.textContent = `Error downloading file: ${error.message}`;
                                    errorDisplay.style.display = 'block';
                                } else {
                                    console.error(`Error downloading ${filename}: ${error.message}`);
            }
                    })
                    .finally(() => {
                        spinner.style.display = 'none';
                    });
                    }


            function showDeleteConfirmation(filePath, fileName) {
                currentFilePath = filePath;
                fileToDelete.textContent = fileName;
                deleteModal.style.display = 'flex';
            }
            
            function deleteFile(filePath) {
                const fileName = filePath.split('/').pop();
                deleteModal.style.display = 'none';
                
                fetch(`/manage:delete?filename=${encodeURIComponent(fileName)}`)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Failed to delete file');
                        }
                    fetchPayloads();
                })
                .catch(error => {
                        alert(`Error deleting file: ${error.message}`);
                })
                .finally(() => {
                        currentFilePath = '';
                    });
            }
            
            function uploadFile(file) {
                uploadStatus.textContent = 'Adding File';
                uploadMessage.textContent = `Adding ${file.name}...`;
                uploadSpinner.style.display = 'block';
                closeUpload.style.display = 'none';
                uploadModal.style.display = 'flex';
                
                const formData = new FormData();
                formData.append('file', file);
                
                fetch(`/manage:upload?filename=${encodeURIComponent(file.name)}`, {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.text().then(text => {
                    if (!response.ok) {
                        throw new Error(text || `Upload failed with status: ${response.status}`);
                    }
                    if (text.startsWith('Error:')) {
                        throw new Error(text);
                    }
                    return text;
                }))
                .then(successText => {
                    uploadStatus.textContent = 'Payload added';
                    uploadMessage.textContent = `${file.name} has been added successfully.`;
                    fetchPayloads();
                })
                .catch(error => {
                    uploadStatus.textContent = 'Error adding payload';
                    uploadMessage.textContent = error.message;
                })
                .finally(() => {
                    uploadSpinner.style.display = 'none';
                    closeUpload.style.display = 'inline-block';
                    fileInput.value = '';
                });
            }

            const menuVersion = "";
            function getVersion() {
            fetch('/version')
                .then(response => response.text())
                .then(data => {
                    if (data === 'error') {
                        console.log('Error fetching menu version');
                    } else {
                        const versionElement = document.querySelector('.menu-version');
                        versionElement.textContent = `v${data}`;
                    }
                })
                .catch(error => {
                    console.error('Error fetching menu version:', error);
                });
            }
            getVersion();
        });
    </script>
</body>
</html>
]]


function get_savedata_path()
    local path = "/savedata0/"
    if is_jailbroken() then
        path = "/mnt/sandbox/" .. get_title_id() .. "_000/savedata0/"
    end
    return path
end

function load_and_run_lua(path)
    local lua_code = file_read(path, "r")
    run_lua_code(lua_code)
end

function kill_this_app()
    syscall.kill(syscall.getpid(), 15)
end

local old_print = print
local old_printf = printf

local print_history = {}
local max_history_size = 100

function print(...)
    old_print(...)
        local args = {...}
    local message = ""
    for i, v in ipairs(args) do
        message = message .. tostring(v)
        if i < #args then
            message = message .. "\t"
        end
    end
    table.insert(print_history, message)
    if #print_history > max_history_size then
        table.remove(print_history, 1)
    end
end

function printf(...)
    old_printf(...)
    local args = {...}
    local message = ""
    for i, v in ipairs(args) do
        message = message .. tostring(v)
        if i < #args then
            message = message .. "\t"
        end
    end
    table.insert(print_history, message)
    if #print_history > max_history_size then
        table.remove(print_history, 1)
    end
end

function get_print_history()
    return print_history
end


function convert_to_json(t, name)
    local json_result = "{"
    json_result = json_result .. "\"" .. name .. "\":["
    for i, v in ipairs(t) do
        -- First escape backslashes (must be done first)
        v = v:gsub('\\', '\\\\')
        -- Then escape other special characters
        v = v:gsub('"', '\\"')
        v = v:gsub('\n', '\\n')
        v = v:gsub('\r', '\\r')
        v = v:gsub('\t', '\\t')
        v = v:gsub('\b', '\\b')
        v = v:gsub('\f', '\\f')
        json_result = json_result .. '"' .. v .. '"'
        if i < #t then
            json_result = json_result .. ","
        end
    end
    json_result = json_result .. "]}"
    return json_result
end

function htons(port)
    return bit32.bor(bit32.lshift(port, 8), bit32.rshift(port, 8)) % 0x10000
end

function get_local_ip_address()
    -- Create a UDP socket
    local sock = syscall.socket(2, 2, 0):tonumber() -- AF_INET=2, SOCK_DGRAM=2
    assert(sock >= 0, "socket creation failed")
    
    -- Prepare address structure for Google's DNS (8.8.8.8:53)
    local addr = memory.alloc(16)
    memory.write_byte(addr + 0, 16)       -- sa_len
    memory.write_byte(addr + 1, 2)        -- AF_INET
    memory.write_word(addr + 2, htons(53)) -- Port 53 (DNS)
    
    -- 8.8.8.8 (Google DNS)
    memory.write_byte(addr + 4, 8)
    memory.write_byte(addr + 5, 8)
    memory.write_byte(addr + 6, 8)
    memory.write_byte(addr + 7, 8)
    
    -- Connect (this doesn't actually establish a connection for UDP)
    local result = syscall.connect(sock, addr, 16):tonumber()
    if result < 0 then
        syscall.close(sock)
        print("Connect failed")
        return nil
    end

    local local_addr = memory.alloc(16)
    local addr_len = memory.alloc(4)
    memory.write_dword(addr_len, 16)
    
    result = syscall.getsockname(sock, local_addr, addr_len):tonumber()
    if result < 0 then
        syscall.close(sock)
        print("Getsockname failed")
        return nil
    end
    
    local ip1 = memory.read_byte(local_addr + 4):tonumber()
    local ip2 = memory.read_byte(local_addr + 5):tonumber()
    local ip3 = memory.read_byte(local_addr + 6):tonumber()
    local ip4 = memory.read_byte(local_addr + 7):tonumber()
    
    syscall.close(sock)
    
    local ip_address = string.format("%d.%d.%d.%d", ip1, ip2, ip3, ip4)
    return ip_address
end

function sceStat(path, st)
    return syscall.stat(path, st):tonumber()
end
function sceGetdents(sck, buf, len)
    return syscall.getdents(sck, buf, len):tonumber()
end
function read_u8(addr)
    local f = memory.read_buffer(addr, 1)
    return f:byte(1)
end
function read_u16(addr)
    local f = memory.read_buffer(addr, 2)
    local lo = f:byte(2)
    local hi = f:byte(1)
    return bit32.bor(hi, bit32.lshift(lo, 8))
end

function ensure_directory_exists(path)
    local st = memory.alloc(128)
    local stat_result = syscall.stat(path, st):tonumber()
    if stat_result < 0 then
        -- Directory doesn't exist, create it
        -- chmod 0755
        local result = syscall.mkdir(path, 0x1ED):tonumber()
        if result < 0 then
            print("Failed to create directory: " .. path)
            return false
        else
            print("Created directory: " .. path)
            return true
        end
    end
    return true
end



function get_config()
    local config_path = "/data/ps5_lua_loader/menu_config.txt"
    local config_table = {}
    
    local config_file = io.open(config_path, "r")
    
    if config_file then
        for line in config_file:lines() do
            -- Skip empty lines and comments
            if line ~= "" and line:sub(1, 1) ~= "#" then
                -- Split the line at the equals sign
                local name, value = line:match("([^=]+)=(.+)")
                if name and value then
                    name = name:gsub("%s+$", "") -- Trim trailing spaces
                    value = value:gsub("^%s+", "") -- Trim leading spaces
                    
                    -- Convert string values to appropriate types
                    if value == "true" then
                        value = true
                    elseif value == "false" then
                        value = false
                    elseif tonumber(value) then
                        value = tonumber(value)
                    end
                    
                    config_table[name] = value
                end
            end
        end
        config_file:close()
    end
    
    return config_table
end

function set_config(name, value)
    if not name then
        print("Error: Configuration name cannot be nil")
        return false
    end
    local config_table = get_config()
    config_table[name] = value
    return save_config(config_table)
end

function save_config(config_table)
    if type(config_table) ~= "table" then
        print("Error: Configuration must be a table")
        return false
    end
    
    local config_path = "/data/ps5_lua_loader/menu_config.txt"
    
    ensure_directory_exists("/data/ps5_lua_loader/")
    
    local config_file = io.open(config_path, "w")
    if not config_file then
        print("Error: Failed to open config file: " .. config_path)
        return false
    end

    for name, value in pairs(config_table) do
        config_file:write(name .. "=" .. tostring(value) .. "\n")
    end
    
    config_file:close()
    
    print("Configuration saved successfully to: " .. config_path)
    return true
end


-- source: https://github.com/shahrilnet/remote_lua_loader/blob/main/payloads/elf_loader.lua
-- rudimentary elf loader
-- only expected to load john tornblom's elfldr.elf

-- credit to nullptr for porting and specter for the original code


elf_loader = {}
elf_loader.__index = elf_loader

elf_loader.options = {
    elf_dirname = "ps5_lua_loader", -- directory where elfldr.elf is located
    elf_filename = "elfldr.elf",
}

elf_loader.shadow_mapping_addr = uint64(0x920100000)
elf_loader.mapping_addr = uint64(0x926100000)

function elf_loader:load_from_file(filepath)

    if not file_exists(filepath) then
        errorf("file not exist: %s", filepath)
    end

    local self = setmetatable({}, elf_loader)
    
    self.filepath = filepath
    self.elf_data = file_read(filepath)
    self.parse(self)
    
    return self
end

function elf_loader:parse()

    -- ELF sizes and offsets
    local SIZE_ELF_HEADER = 0x40
    local SIZE_ELF_PROGRAM_HEADER = 0x38
    local SIZE_ELF_SECTION_HEADER = 0x40

    local OFFSET_ELF_HEADER_ENTRY = 0x18
    local OFFSET_ELF_HEADER_PHOFF = 0x20
    local OFFSET_ELF_HEADER_SHOFF = 0x28
    local OFFSET_ELF_HEADER_PHNUM = 0x38
    local OFFSET_ELF_HEADER_SHNUM = 0x3c

    local OFFSET_PROGRAM_HEADER_TYPE = 0x00
    local OFFSET_PROGRAM_HEADER_FLAGS = 0x04
    local OFFSET_PROGRAM_HEADER_OFFSET = 0x08
    local OFFSET_PROGRAM_HEADER_VADDR = 0x10
    local OFFSET_PROGRAM_HEADER_FILESZ = 0x20
    local OFFSET_PROGRAM_HEADER_MEMSZ = 0x28

    local OFFSET_SECTION_HEADER_TYPE = 0x4
    local OFFSET_SECTION_HEADER_OFFSET = 0x18
    local OFFSET_SECTION_HEADER_SIZE = 0x20

    local OFFSET_RELA_OFFSET = 0x00
    local OFFSET_RELA_INFO = 0x08
    local OFFSET_RELA_ADDEND = 0x10

    local SHT_RELA = 0x4
    local RELA_ENTSIZE = 0x18

    local PF_X = 1

    -- ELF program header types
    local ELF_PT_LOAD = 0x01
    local ELF_PT_DYNAMIC = 0x02

    -- ELF dynamic table types
    local ELF_DT_NULL = 0x00
    local ELF_DT_RELA = 0x07
    local ELF_DT_RELASZ = 0x08
    local ELF_DT_RELAENT = 0x09
    local ELF_R_AMD64_RELATIVE = 0x08

    local elf_store = lua.resolve_value(self.elf_data)

    local elf_entry = memory.read_dword(elf_store + OFFSET_ELF_HEADER_ENTRY):tonumber()
    self.elf_entry_point = elf_loader.mapping_addr + elf_entry

    local elf_program_headers_offset = memory.read_dword(elf_store + OFFSET_ELF_HEADER_PHOFF):tonumber()
    local elf_program_headers_num = memory.read_word(elf_store + OFFSET_ELF_HEADER_PHNUM):tonumber()

    local elf_section_headers_offset = memory.read_dword(elf_store + OFFSET_ELF_HEADER_SHOFF):tonumber()
    local elf_section_headers_num = memory.read_word(elf_store + OFFSET_ELF_HEADER_SHNUM):tonumber()

    local executable_start = 0
    local executable_end = 0

    -- parse program headers
    for i = 0, elf_program_headers_num-1 do

        local phdr_offset = elf_program_headers_offset + (i * SIZE_ELF_PROGRAM_HEADER)
        local p_type = memory.read_dword(elf_store + phdr_offset + OFFSET_PROGRAM_HEADER_TYPE):tonumber()
        local p_flags = memory.read_dword(elf_store + phdr_offset + OFFSET_PROGRAM_HEADER_FLAGS):tonumber()
        local p_offset = memory.read_dword(elf_store + phdr_offset + OFFSET_PROGRAM_HEADER_OFFSET):tonumber()
        local p_vaddr = memory.read_dword(elf_store + phdr_offset + OFFSET_PROGRAM_HEADER_VADDR):tonumber()
        local p_filesz = memory.read_dword(elf_store + phdr_offset + OFFSET_PROGRAM_HEADER_FILESZ):tonumber()
        local p_memsz = memory.read_dword(elf_store + phdr_offset + OFFSET_PROGRAM_HEADER_MEMSZ):tonumber()
        local aligned_memsz = bit32.band(p_memsz + 0x3FFF, 0xFFFFC000)

        if p_type == ELF_PT_LOAD then

            local PROT_RW = bit32.bor(PROT_READ, PROT_WRITE)
            local PROT_RWX = bit32.bor(PROT_READ, PROT_WRITE, PROT_EXECUTE)

            if bit32.band(p_flags, PF_X) == PF_X then

                executable_start = p_vaddr
                executable_end = p_vaddr + p_memsz 

                -- create shm with exec permission
                local exec_handle = syscall.jitshm_create(0, aligned_memsz, 0x7)

                -- create shm alias with write permission
                local write_handle = syscall.jitshm_alias(exec_handle, 0x3)

                -- map shadow mapping and write into it
                syscall.mmap(elf_loader.shadow_mapping_addr, aligned_memsz, PROT_RW, 0x11, write_handle, 0)
                memory.memcpy(elf_loader.shadow_mapping_addr, elf_store + p_offset, p_memsz)

                -- map executable segment
                syscall.mmap(elf_loader.mapping_addr + p_vaddr, aligned_memsz, PROT_RWX, 0x11, exec_handle, 0)
            else
                -- copy regular data segment
                syscall.mmap(elf_loader.mapping_addr + p_vaddr, aligned_memsz, PROT_RW, 0x1012, 0xFFFFFFFF, 0)
                memory.memcpy(elf_loader.mapping_addr + p_vaddr, elf_store + p_offset, p_memsz)
            end
        end
    end

    -- apply relocations
    for i = 0, elf_section_headers_num-1 do

        local shdr_offset = elf_section_headers_offset + (i * SIZE_ELF_SECTION_HEADER)

        local sh_type = memory.read_dword(elf_store + shdr_offset + OFFSET_SECTION_HEADER_TYPE):tonumber()
        local sh_offset = memory.read_qword(elf_store + shdr_offset + OFFSET_SECTION_HEADER_OFFSET):tonumber()
        local sh_size = memory.read_qword(elf_store + shdr_offset + OFFSET_SECTION_HEADER_SIZE):tonumber()

        if sh_type == SHT_RELA then

            local rela_table_count = sh_size / RELA_ENTSIZE

            -- Parse relocs and apply them
            for i = 0, rela_table_count-1 do

                local r_offset = memory.read_qword(elf_store + sh_offset + (i * RELA_ENTSIZE) + OFFSET_RELA_OFFSET):tonumber()
                local r_info = memory.read_qword(elf_store + sh_offset + (i * RELA_ENTSIZE) + OFFSET_RELA_INFO):tonumber()
                local r_addend = memory.read_qword(elf_store + sh_offset + (i * RELA_ENTSIZE) + OFFSET_RELA_ADDEND):tonumber()

                if bit32.band(r_info, 0xFF) == ELF_R_AMD64_RELATIVE then
                    
                    local reloc_addr = elf_loader.mapping_addr + r_offset
                    local reloc_value = elf_loader.mapping_addr + r_addend

                    -- If the relocation falls in the executable section, we need to redirect the write to the
                    -- writable shadow mapping or we'll crash
                    if executable_start <= r_offset and r_offset < executable_end then
                        reloc_addr = elf_loader.shadow_mapping_addr + r_offset
                    end
                
                    memory.write_qword(reloc_addr, reloc_value)
                end
            end
        end
    end

    return

end

function elf_loader:run()

    local Thrd_create = fcall(libc_addrofs.Thrd_create)

    local rwpipe = memory.alloc(8)
    local rwpair = memory.alloc(8)
    local args = memory.alloc(0x30)
    local thr_handle_addr = memory.alloc(8)

    memory.write_dword(rwpipe, ipv6_kernel_rw.data.pipe_read_fd)
    memory.write_dword(rwpipe + 0x4, ipv6_kernel_rw.data.pipe_write_fd)

    memory.write_dword(rwpair, ipv6_kernel_rw.data.master_sock)
    memory.write_dword(rwpair + 0x4, ipv6_kernel_rw.data.victim_sock)

    local syscall_wrapper = dlsym(0x2001, "getpid")

    self.payloadout = memory.alloc(4)

    memory.write_qword(args + 0x00, syscall_wrapper)                -- arg1 = syscall wrapper
    memory.write_qword(args + 0x08, rwpipe)                         -- arg2 = int *rwpipe[2]
    memory.write_qword(args + 0x10, rwpair)                         -- arg3 = int *rwpair[2]
    memory.write_qword(args + 0x18, ipv6_kernel_rw.data.pipe_addr)  -- arg4 = uint64_t kpipe_addr
    memory.write_qword(args + 0x20, kernel.addr.data_base)          -- arg5 = uint64_t kdata_base_addr
    memory.write_qword(args + 0x28, self.payloadout)                -- arg6 = int *payloadout

    printf("spawning %s", self.filepath)

    -- spawn elf in new thread
    local ret = Thrd_create(thr_handle_addr, self.elf_entry_point, args):tonumber()
    if ret ~= 0 then
        error("Thrd_create() error: " .. hex(ret))
    end

    self.thr_handle = memory.read_qword(thr_handle_addr)
end

function elf_loader:wait_for_elf_to_exit()

    local Thrd_join = fcall(libc_addrofs.Thrd_join)

    -- will block until elf terminates
    local ret = Thrd_join(self.thr_handle, 0):tonumber()
    if ret ~= 0 then
        error("Thrd_join() error: " .. hex(ret))
    end

    local out = memory.read_dword(self.payloadout)
    printf("out = %s", hex(out))
end


function elf_loader:main()
    check_jailbroken()
    if elf_loader_active then
        render_notification({"elfldr already running"})
        return
    end

    syscall.resolve({
        jitshm_create = 0x215,
        jitshm_alias = 0x216,
        mprotect = 0x4a,
    })

    run_with_ps5_syscall_enabled(function()
        local elf_dirname = elf_loader.options.elf_dirname
        local elf_filename = elf_loader.options.elf_filename

        -- Build possible paths, prioritizing USBs first, then /data, then savedata
        local possible_paths = {}
        for i = 0, 7 do
            table.insert(possible_paths, string.format("/mnt/usb%d/%s/%s", i, elf_dirname, elf_filename))
        end
        table.insert(possible_paths, string.format("/data/%s/%s", elf_dirname, elf_filename))
        table.insert(possible_paths, get_savedata_path() .. elf_dirname .. "/" .. elf_filename)
        table.insert(possible_paths, get_savedata_path() .. elf_filename)

        local existing_path = nil
        for _, path in ipairs(possible_paths) do
            if file_exists(path) then
                existing_path = path
                break
            end
        end

        if not existing_path then
            send_ps_notification("Error: " .. elf_filename .. " not found in any known location\nPlease place it in /data or in root of USB drive")
            errorf("file not exist in any known location")
        end

        printf("loading %s from: %s", elf_filename, existing_path)

        local elf = elf_loader:load_from_file(existing_path)
        elf:run()
        elf:wait_for_elf_to_exit()
    end)
    elf_loader_active = true
    print("done")
end


elf_sender = {}
elf_sender.__index = elf_sender

function elf_sender:load_from_file(filepath)

    if not elf_loader_active and autoloading then
        elf_loader:main()
        sleep(4000, "ms")
    end

    if file_exists(filepath) then
        print("Loading elf from:", filepath)
    else
        self.error = "File not found: " .. filepath
        return self
    end

    local self = setmetatable({}, elf_sender)
    self.filepath = filepath
    self.elf_data = file_read(filepath)
    self.elf_size = #self.elf_data

    print("elf size: " .. self.elf_size .. " bytes")
    return self
end

function elf_sender:sceNetSend(sockfd, buf, len, flags, addr, addrlen)
    return syscall.send(sockfd, buf, len, flags, addr, addrlen):tonumber()
end
function elf_sender:sceNetSocket(domain, type, protocol)
    return syscall.socket(domain, type, protocol):tonumber()
end
function elf_sender:sceNetSocketClose(sockfd)
    return syscall.close(sockfd):tonumber()
end
function elf_sender:htons(port)
    return bit32.bor(bit32.lshift(port, 8), bit32.rshift(port, 8)) % 0x10000
end

function elf_sender:send_to_localhost(port)

    if self.error then
        print("[-] Error: " .. self.error)
        send_ps_notification("[-] Error: " .. self.error)
        return false
    end

    if not elf_sender:check_if_elfloader_is_running(9021) then
        elf_loader:main()
        sleep(4000, "ms")
    end

    local sockfd = elf_sender:sceNetSocket(2, 1, 0) -- AF_INET=2, SOCK_STREAM=1
    assert(sockfd >= 0, "socket creation failed")
    local enable = memory.alloc(4)
    memory.write_dword(enable, 1)
    syscall.setsockopt(sockfd, 1, 2, enable, 4) -- SOL_SOCKET=1, SO_REUSEADDR=2

    local sockaddr = memory.alloc(16)

    memory.write_byte(sockaddr + 0, 16)
    memory.write_byte(sockaddr + 1, 2) -- AF_INET
    memory.write_word(sockaddr + 2, elf_sender:htons(port))

    memory.write_byte(sockaddr + 4, 0x7F) -- 127
    memory.write_byte(sockaddr + 5, 0x00) -- 0
    memory.write_byte(sockaddr + 6, 0x00) -- 0
    memory.write_byte(sockaddr + 7, 0x01) -- 1


    local connect_result = syscall.connect(sockfd, sockaddr, 16):tonumber()

    if connect_result < 0 then
        elf_sender:sceNetSocketClose(sockfd)
        print("[ERROR]:\nELF Loader not running")
        send_ps_notification("[ERROR]:\nELF Loader not running")
        return false
    end

    local buf = memory.alloc(#self.elf_data)
    memory.write_buffer(buf, self.elf_data)

    local total_sent = elf_sender:sceNetSend(sockfd, buf, #self.elf_data, 0, sockaddr, 16)
    elf_sender:sceNetSocketClose(sockfd)
    if total_sent < 0 then
        print("[-] error sending elf data to localhost")
        send_ps_notification("error sending elf data to localhost")
        return
    end
    print(string.format("Successfully sent %d bytes to loader", total_sent))
end


function elf_sender:check_if_elfloader_is_running(port)
    local sockfd = elf_sender:sceNetSocket(2, 1, 0) -- AF_INET=2, SOCK_STREAM=1
    assert(sockfd >= 0, "socket creation failed")
    local enable = memory.alloc(4)
    memory.write_dword(enable, 1)
    syscall.setsockopt(sockfd, 1, 2, enable, 4) -- SOL_SOCKET=1, SO_REUSEADDR=2

    local sockaddr = memory.alloc(16)

    memory.write_byte(sockaddr + 0, 16)
    memory.write_byte(sockaddr + 1, 2) -- AF_INET
    memory.write_word(sockaddr + 2, elf_sender:htons(port))

    memory.write_byte(sockaddr + 4, 0x7F) -- 127
    memory.write_byte(sockaddr + 5, 0x00) -- 0
    memory.write_byte(sockaddr + 6, 0x00) -- 0
    memory.write_byte(sockaddr + 7, 0x01) -- 1

    local connect_result = syscall.connect(sockfd, sockaddr, 16):tonumber()
    elf_sender:sceNetSocketClose(sockfd)

    if connect_result < 0 then
        print("ELF Loader not running, starting it")
        send_ps_notification("ELF Loader not running, starting it")
        return false
    else
        print("ELF Loader is already running")
        return true
    end
end


function process_uploaded_file(filename, file_content)
    ensure_directory_exists("/data/ps5_lua_loader/")

    if filename:match("/") or filename:match("%.%./") or filename:match("/%.%." ) or filename == ".." then
        local err_msg = "Error: Invalid filename. Path traversal attempt detected: " .. filename
        print(err_msg)
        return false, err_msg
    end

    local file_path = "/data/ps5_lua_loader/" .. filename
    
    local check_file = io.open(file_path, "rb")
    if check_file then
        check_file:close()
        print("Error: File already exists: " .. filename)
        return false, "Error: File already exists: " .. filename
    end
    
    local file_handle = io.open(file_path, "wb")
    if not file_handle then
        return false, "Error: Failed to open file for writing: " .. file_path
    end
    
    local success, err = file_handle:write(file_content)
    file_handle:close()

    if not success then
        return false, "Error: Failed to write file content: " .. (err or "unknown error")
    end
    
    return true
end


function remove_file(filename)
    local file_path = "/data/ps5_lua_loader/" .. filename
    print("Attempting to remove file: " .. file_path)

    if filename:match("/") or filename:match("%.%./") or filename:match("/%.%." ) or filename == ".." then
        local err_msg = "Error: Invalid filename. Path traversal attempt detected: " .. filename
        print(err_msg)
        return false, err_msg
    end

    local result = syscall.unlink(file_path):tonumber()

    if result == 0 then
        print("Successfully removed file: " .. file_path)
        return true
    else
        local err_msg = "Error: Failed to remove file: " .. file_path .. " (System Error: " .. result .. ")"
        print(err_msg)
        return false, err_msg
    end
end


function list_payloads(only_data)

    -- Initialize empty array for results
    local matching_files = {}
    
    -- Define the directories to scan
    local directories = {"/data/ps5_lua_loader/"}
    
    -- Add USB directories
    if not only_data then
        for i = 0, 7 do
            table.insert(directories, "/mnt/usb" .. i .. "/ps5_lua_loader/")
        end
    end

    -- Allocate memory for file operations
    local st = memory.alloc(128)  -- stat structure
    local contents = memory.alloc(4096)  -- buffer for directory entries

    -- Scan each directory
    for _, dir_path in ipairs(directories) do
        -- print("Scanning directory: " .. dir_path)
        
        local fd = syscall.open(dir_path, 0, 0):tonumber()
        if fd < 0 then
            -- print("Failed to open directory: " .. dir_path)
        else
            syscall.fsync(fd)

            while true do
                local nread = sceGetdents(fd, contents, 4096)
                if nread <= 0 then break end
                
                local entry = contents
                local end_ptr = contents + nread
                
                while entry < end_ptr do
                    local length = read_u16(entry + 0x4)
                    if length == 0 then break end
                    
                    local name = memory.read_buffer(entry + 0x8, 64)
                    name = name:match("([^%z]+)") -- Remove null terminator
                    
                    if not name:match("^%.") then
                        local full_path = dir_path .. name
                        if name:match("%.lua$") or name:match("%.elf$") or name:match("%.bin$") then
                            if name ~= "ps5_lua_menu.lua" and name ~= "elfldr.elf" then
                                table.insert(matching_files, full_path)
                            end
                        end
                    end
                    
                    entry = entry + length
                end
            end
            syscall.close(fd)
        end
    end
    
    return matching_files
end



function load_payload(full_path)
    if full_path:match("%.elf$") or full_path:match("%.bin$") then
        elf_sender:load_from_file(full_path):send_to_localhost(9021)
    elseif full_path:match("%.lua$") then
        load_and_run_lua(full_path)
    end
end


local http_server = {}

http_server.last_keepalive = os.time()
http_server.should_shutdown = false

local AF_INET = 2
local SOCK_STREAM = 1
local SOL_SOCKET = 0xFFFF
local SO_REUSEADDR = 0x00000004
local INADDR_ANY = 0

http_server.fd = nil

-- HTTP response template
local HTTP_RESPONSE = [[HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
Connection: close
Content-Length: %d

%s]]

-- HTML_CONTENT is set in main.lua

function http_server.htons(port)
    return bit32.bor(bit32.lshift(port, 8), bit32.rshift(port, 8)) % 0x10000
end

function http_server.shutdown()
    if http_server.fd then
        print("Closing server socket")
        syscall.close(http_server.fd)
        http_server.fd = nil
    end
end


function http_server.create_server(port)
    -- Create socket
    local sockfd = syscall.socket(AF_INET, SOCK_STREAM, 0):tonumber()
    assert(sockfd >= 0, "Server socket creation failed")
    
    -- Set socket options
    local enable = memory.alloc(4)
    memory.write_dword(enable, 1)
    local setsockopt_result = syscall.setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, enable, 4):tonumber()
    -- print("setsockopt result:", setsockopt_result)


    local enable = memory.alloc(4)
    memory.write_dword(enable, 1)

    -- Prepare sockaddr structure
    local sockaddr = memory.alloc(16)
    memory.write_byte(sockaddr + 0, 16)       -- sa_len
    memory.write_byte(sockaddr + 1, AF_INET)  -- sa_family
    memory.write_word(sockaddr + 2, http_server.htons(port)) -- sin_port
    memory.write_dword(sockaddr + 4, INADDR_ANY) -- sin_addr (0.0.0.0)

    -- Bind socket
    local bind_result = syscall.bind(sockfd, sockaddr, 16):tonumber()
    if bind_result < 0 then
        print("Bind failed:", bind_result)
        syscall.close(sockfd)
        return nil
    end
    
    -- Listen for connections
    local listen_result = syscall.listen(sockfd, 5):tonumber()
    if listen_result < 0 then
        print("Listen failed:", listen_result)
        syscall.close(sockfd)
        return nil
    end
    
    print("HTTP server started (socket fd: " .. sockfd .. "), listening on port " .. port)
    return sockfd
end

function http_server.accept_client(server_fd)
    local client_addr = memory.alloc(16)
    local addr_len = memory.alloc(4)
    memory.write_dword(addr_len, 16)
    
    local client_fd = syscall.accept(server_fd, client_addr, addr_len):tonumber()
    if client_fd < 0 then
        print("Accept failed:", client_fd)
        return nil
    end
    
    return client_fd
end


function http_server.accept_client_with_timeout(server_fd, timeout_ms)
    -- Set socket to non-blocking
    local flags = syscall.fcntl(server_fd, 3, 0):tonumber() -- F_GETFL = 3
    syscall.fcntl(server_fd, 4, bit32.bor(flags, 0x4)):tonumber() -- F_SETFL = 4, O_NONBLOCK = 0x4
    
    local client_fd = syscall.accept(server_fd, nil, nil):tonumber()
    
    -- If no client, sleep a bit and return nil
    if client_fd < 0 then
        sleep(timeout_ms, "ms")
        return nil
    end
    
    -- Set client socket back to blocking mode
    flags = syscall.fcntl(client_fd, 3, 0):tonumber()
    syscall.fcntl(client_fd, 4, bit32.band(flags, bit32.bnot(0x4))):tonumber()
    
    return client_fd
end


function http_server.read_request(client_fd)
    -- First read the headers with a smaller buffer
    local header_buffer = memory.alloc(4096)
    local bytes_read = syscall.recv(client_fd, header_buffer, 4096, 0):tonumber()
    
    if bytes_read <= 0 then
        return nil
    end
    
    local headers = memory.read_buffer(header_buffer, bytes_read)
    
    -- Check if this is a POST request with content
    local method = headers:match("^(%S+)%s+")
    local content_length = headers:match("Content%-Length:%s*(%d+)")
    
    if method == "POST" and content_length then
        content_length = tonumber(content_length)
        
        -- If we have a large POST, process it in chunks
        if content_length > 0 then
            -- Check if we already received the full content
            local header_end = headers:find("\r\n\r\n")
            local body_start = header_end and header_end + 4 or nil
            
            if body_start and bytes_read - body_start + 1 >= content_length then
                -- We already have the full request
                return headers
            else
                -- Need to read more data in chunks
                local CHUNK_SIZE = 1024 * 1024  -- 1MB chunks
                
                -- Calculate how much of the body we already have
                local body_bytes_received = bytes_read - body_start + 1
                local body_bytes_remaining = content_length - body_bytes_received
                
                -- Create a buffer for the full request
                local full_request = headers
                
                -- Read the rest of the body in chunks
                while body_bytes_remaining > 0 do
                    local chunk_size = math.min(CHUNK_SIZE, body_bytes_remaining)
                    local chunk_buffer = memory.alloc(chunk_size)
                    
                    local chunk_bytes_read = syscall.recv(client_fd, chunk_buffer, chunk_size, 0):tonumber()
                    if chunk_bytes_read <= 0 then
                        print("Error reading chunk: " .. chunk_bytes_read)
                        break
                    end
                    
                    -- Append this chunk to our full request
                    full_request = full_request .. memory.read_buffer(chunk_buffer, chunk_bytes_read)
                    
                    -- Update our counters
                    body_bytes_remaining = body_bytes_remaining - chunk_bytes_read
                end
                
                return full_request
            end
        end
    end
    
    return headers
end



function http_server.extract_post_data(request)
    -- Find the boundary from the Content-Type header
    local boundary = request:match("Content%-Type: multipart/form%-data; boundary=([^\r\n]+)")
    if not boundary then return nil end
    
    -- Format the boundary as it appears in the content
    local content_boundary = "--" .. boundary
    
    -- Find the start of the file content
    local file_start_pattern = content_boundary .. "\r\n" ..
                              "Content%-Disposition: form%-data; name=\"[^\"]+\"; filename=\"[^\"]+\"\r\n" ..
                              "Content%-Type: [^\r\n]+\r\n\r\n"
    
    local content_start = request:match(file_start_pattern .. "()")
    if not content_start then return nil end
    
    -- Find the end boundary
    local content_end = request:find("\r\n" .. content_boundary .. "--", content_start)
    if not content_end then return nil end
    
    -- Extract just the file content between the header and end boundary
    local file_content = request:sub(content_start, content_end - 1)
    return file_content
end


function http_server.send_response(client_fd, content)
    local response = string.format(HTTP_RESPONSE, #content, content)
    local buffer = memory.alloc(#response)
    memory.write_buffer(buffer, response)
    
    local bytes_sent = syscall.send(client_fd, buffer, #response, 0):tonumber()
    return bytes_sent
end

function http_server.parse_request(request)
    local method, path = request:match("^(%S+)%s+(%S+)")
    return method, path
end

function http_server.handle_request(request)
    local method, path = http_server.parse_request(request)
    
    if not method or not path then
        return "Invalid request"
    end
    
    http_server.last_keepalive = os.time()

    -- print("Received", method, "request for", path)
    
    -- Handle different paths
    if path == "/" or path == "/index.html" then
        return HTML_CONTENT

    elseif path == "/manage" then
        return HTML_MANAGE_CONTENT

    elseif path == "/shutdown" then
        http_server.should_shutdown = true
        send_ps_notification("Shutting down HTTP server...")
        return "Server shutting down..."

    elseif path == "/keepalive" then
        return "OK"

    elseif path == "/log" then
        return convert_to_json(get_print_history(), "logs")

    elseif path == "/list_payloads" then
        return convert_to_json(list_payloads(), "payloads")

    elseif path == "/list_payloads:only_data" then
        return convert_to_json(list_payloads(true), "payloads")

    elseif path:match("^/loadpayload:") then
        local payload_path = path:match("^/loadpayload:(.*)")
        payload_path = payload_path:gsub("%%(%x%x)", function(h)
            return string.char(tonumber(h, 16))
        end)
        load_payload(payload_path)
        http_server.last_keepalive = os.time()

        return "Payload loaded: " .. payload_path

    elseif path:match("^/manage:upload%?filename=(.+)$") and method == "POST" then
        local filename = path:match("^/manage:upload%?filename=(.+)$")
        filename = filename:gsub("%%(%x%x)", function(h)
            return string.char(tonumber(h, 16))
        end)

        if not filename:match("%.lua$") and not filename:match("%.elf$") and not filename:match("%.bin$") then
            return "Error: Invalid file extension. Only .lua, .elf, and .bin files can be uploaded."
        end
        
        local file_content = http_server.extract_post_data(request)
        
        if file_content then
            local success, message = process_uploaded_file(filename, file_content)
            if success ~= true then
                return message or "Error: Unknown error during file processing"
            end
            return "OK"
        else
            return "Error: No file content received"
        end


    elseif path:match("^/manage:delete%?filename=(.+)$") then
        local filename = path:match("^/manage:delete%?filename=(.+)$")
        filename = filename:gsub("%%(%x%x)", function(h)
            return string.char(tonumber(h, 16))
        end)

        if not filename:match("%.lua$") and not filename:match("%.elf$") and not filename:match("%.bin$") then
            return "Error: Invalid file extension. Only .lua, .elf, and .bin files can be deleted."
        end
        
        local success, message = remove_file(filename)
        if success then
            return "File deleted: " .. filename
        else
            return message or "Error: Unknown error during file deletion"
        end

    elseif path == "/version" then
        return menu_version

    elseif path == "/getip" then
        local ip = get_local_ip_address()
        if ip then
            return ip
        else
            return "error"
        end
    else
        print("404: Received", method, "request for", path)
        return "404 Not Found"
    end
end


function http_server.run(port)
    port = port or 8080
    http_server.fd = http_server.create_server(port)
    
    if not http_server.fd then
        print("Failed to create server")
        return
    end
    
    http_server.should_shutdown = false
    
    -- Main server loop
    while not http_server.should_shutdown do

        -- Check if client is active
        local current_time = os.time()
        if current_time - http_server.last_keepalive > 4 then
            send_ps_notification("Shutting down Lua Menu server")
            http_server.should_shutdown = true
        end

        local client_fd = http_server.accept_client_with_timeout(http_server.fd, 50)

        if client_fd then
            local request = http_server.read_request(client_fd)
            if request then
                local response = http_server.handle_request(request)
                http_server.send_response(client_fd, response)
            end
            syscall.close(client_fd)
        end
    end

    print("Shutting down HTTP server...")
    syscall.close(http_server.fd)
end


local libSystemService = find_mod_by_name("libSceSystemService.sprx")
sceSystemServiceLaunchWebBrowser = fcall(dlsym(libSystemService.handle, "sceSystemServiceLaunchWebBrowser"))

function openBrowser(port)
    local url = memory.alloc(256)
    memory.write_buffer(url, "http://127.0.0.1:" .. port .. "/\0")
    local ret = sceSystemServiceLaunchWebBrowser(url, 0):tonumber()
end


print("PLK's Lua Menu v" .. menu_version)

openBrowser(SERVER_PORT)
http_server.run(SERVER_PORT)
