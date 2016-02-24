

var SituationForm = React.createClass({

   getDefaultProps: function(){
       return {
           reasonText:"Reason"
       }
   },
   render: function(){
       return(
           <form className="situation-form">
               <div className="row collapse">
                   <div className="small-3 large-2 columns">
                       <span className="prefix">{this.props.reasonText}</span>
                   </div>
                   <div className="small-9 large-10 columns">
                       <input type="text" name="" />
                   </div>
               </div>

               <div className="row">
                   <div className="small-4 large-4 columns">
                       Medications
                   </div>
                   <div className="small-4 large-4 columns">
                       Lab-tests
                   </div>
                   <div className="small-4 large-4 columns">
                       Other documents
                   </div>
               </div>

               <div className="row">
                   <div className="small-4 large-4 columns">
                       <Medications />
                   </div>
                   <div className="small-4 large-4 columns">
                       <input type="file" />
                   </div>
                   <div className="small-4 large-4 columns">
                       <input type="file" />
                   </div>
               </div>

           </form>
       )
   }
});

var Medications = React.createClass({
    getInitialState: function(){
      return {
          inputsCount: 1
      }
    },

   render: function(){
       var inputs = [];
       for (var i = 0; i < this.state.inputsCount; i++){
           inputs.push(i);
       }
       return(
           inputs.map(function(i){
               return <MedicationInput key={i} />
           })
       )
   }
});

var MedicationInput = React.createClass({
    render: function(){
        return(
            <input type="text" />
        )
    }
});
