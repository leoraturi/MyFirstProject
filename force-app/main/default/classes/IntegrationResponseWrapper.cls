public class IntegrationResponseWrapper {
        public boolean isConnectionOK;
        public String connectionMessage ;
        public Exception responseException;
        public HttpResponse response ;
        
        public IntegrationResponseWrapper (boolean isError,String errorMsg,HttpResponse response){
            this.isConnectionOK  = isError;
            this.connectionMessage = errorMsg;
            this.response = response;
        }
        
       public IntegrationResponseWrapper (Exception e, HttpResponse response){          
            this.isConnectionOK  = true;
            this.responseException = e;
            if(e != null) this.connectionMessage = e.getMessage();
            this.response = response;
        }
        
        public IntegrationResponseWrapper (HttpResponse response){
            this.isConnectionOK  = true;
            this.connectionMessage = '';
            this.response = response;
        }
}