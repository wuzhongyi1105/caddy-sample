$(document).ready(function(){
    $(".btn_next").mouseup(function(){
        $(".btn_next").css("border","0");
        $(".btn_next").css("color","#fff");
        $(".btn_next").css("border",0);
    });
    $(".btn_next").mousedown(function(){
        $(".btn_next").css("border-color","#096148");
        $(".btn_next").css("color","#66bab7");
        $(".btn_next").css("border",0);
    });


    //调用一言api
    $(".btn_next").on("click",function(){
        getQuote();
    });

    var content="Blessed is the man, who having nothing to say, abstains from giving wordy evidence of the fact.";
    var author="Paul Erdos";
    var getQuote = function(){
        $.getJSON("https://sslapi.hitokoto.cn/?encode=json",function(json){
            content = json["hitokoto"];
            author = json["from"];
            //console.log(content+"_"+author);
            document.title=author
            $(".quote-content").html(content);
            $(".quote-author").html("——"+author);
        });
    }

    getQuote();


    $(".shareQQ").on("click",function(){
        console.log(content+author);
        window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=http://www.baidu.com&desc='+content+'——'+author+'&title=吟游佳句&summary=我发现了一句很漂亮的话，快来看看吧&pics=&site=bshare');
    });


});