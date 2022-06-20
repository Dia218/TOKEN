    const exampleInputEmail = "admin";
    const exampleInputPassword = "1234";
    
    function login(){
        
        if(exampleInputEmail == document.querySelector("#exampleInputEmail").value) {
            if(exampleInputPassword == document.querySelector("#exampleInputPassword").value) {
                window.location.href='/';              
            }
            else {
                alert("비밀번호가 맞지 않습니다.");
                //document.write("비밀번호가 맞지 않습니다.");
            }
        }
        else {
            alert("아이디 혹은 비밀번호가 맞지 않습니다.");
            //document.wrtie("아이디 혹은 비밀번호가 맞지 않습니다.");
        }
    }
