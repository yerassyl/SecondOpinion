var DiseaseBox = React.createClass({
   getInitialState: function(){
    return {
        diseasesList: [],
        form: [],
        formClass: "hide",
        trashClass: "hide"
    }
   },
   componentDidMount: function(){
       $.ajax({
           url: this.props.url_get+"?id="+this.props.patient_id,
           dataType: 'json',
           success: function(data){
               this.setState({diseasesList: data.diseasesList});
               this.setState({form: data.form});
           }.bind(this),
           error: function(xhr, status, err){
               console.error(this.props.url, status, err.toString());
           }.bind(this)
       });
   },
    handleDiseaseSubmit: function(disease){
        // optimistic add
        var diseases = this.state.diseasesList;
        disease.id = Date.now();
        var newDiseases = diseases.concat([disease]);
        this.setState({diseasesList: newDiseases});

        //declare form data to be submitted
        var formData = {
            csrf_token: disease.csrf_token,
            csrf_param: disease.csrf_param,
            'disease[diagnose]': disease.diagnose,
            'disease[treatment]': disease.treatment,
            'disease[other]': disease.otherInformation,
            'disease[condition]': disease.condition,
            'disease[patient_id]': this.props.patient_id
        };
        $.ajax({
            url: this.props.url_post,
            dataType: 'json',
            method: 'POST',
            data: formData,
            success: function(data){
                this.setState({diseasesList: data.diseasesList });
            }.bind(this),
            error: function(xhr, status, err){
                this.setState({diseasesList: diseases });
                console.error(this.props.url_post, status, err.toString());
            }.bind(this)
        });
    },
    handleDiseaseDelete: function(disease){
        // optimistic delete
        var diseases = this.state.diseasesList;
        var newDiseases = diseases.filter(function(a){
            return a.id != disease.id;
        });
        this.setState({diseasesList: newDiseases});
        $.ajax({
            url: this.props.url_delete,
            dataType: 'json',
            method: 'DELETE',
            data: {disease_id: disease.id},
            success: function(data){
                //this.setState({allergiesList: data.allergiesList});
            }.bind(this),
            error: function(xhr,status,err){
                this.setState({diseasesList: diseases});
                console.error(this.props.url_delete, status, err.toString());
            }.bind(this)
        });
    },
    handleFormToggle: function(toggle){
        var formClass = (toggle) ? "show" : "hide";
        this.setState({formClass: formClass});
    },
    handleTrashToggle: function(toggle){
        var formClass = (toggle) ? "show" : "hide";
        this.setState({trashClass: formClass});
    },
   render: function(){
       return(
           <div className="diseases">
                <DiseasesList onDiseaseDelete={this.handleDiseaseDelete}
                              diseasesList={this.state.diseasesList}
                              trashClass={this.state.trashClass} />

                <DiseaseMenu onFormClassChange={this.handleFormToggle}
                             onToggleTrash={this.handleTrashToggle} />

                <DiseaseForm onDiseaseSubmit={this.handleDiseaseSubmit}
                             form={this.state.form}
                             formClass={this.state.formClass} />
           </div>
       )
   }
});

var DiseasesList = React.createClass({
    getDefaultProps: function(){
      return {
          diseasesList: []
      }
    },
    handleDiseaseDelete: function(disease){
        this.props.onDiseaseDelete({
            id: disease.id
        });
    },
    render: function(){
        var diseasesList = this.props.diseasesList.map(function(disease){
           return(
               <Disease onDiseaseDelete={this.handleDiseaseDelete}
                        key={disease.id} diseaseObj={disease}
                        trashClass={this.props.trashClass} />
           )
        },this);
        return(
            <ul>
                {diseasesList}
            </ul>
        )
    }
});

var Disease = React.createClass({

   deleteDisease: function(e){
       e.preventDefault();
       var disease_id = this.props.diseaseObj.id;
       this.props.onDiseaseDelete({
           id: disease_id
       });
   },
   render: function(){
       //console.log(this.props.diseaseObj.condition);
       var condition = (this.props.diseaseObj.condition=="true") ? 'Issue' : 'Not an issue';
       var treatment = (this.props.diseaseObj.treatment=="true") ? 'Taking treatment' : 'Not taking treatment';

       return (
            <li className="disease-obj">
                {this.props.diseaseObj.diagnose}
                <span className="fr">
                    <span className={this.props.trashClass}>
                        <a href="#" onClick={this.deleteDisease} className="fa fa-trash" > </a>
                    </span>
                </span>
                <br/>
                {this.props.diseaseObj.other}<br/>
                <span className="disease-extra">{condition} | {treatment}</span>
            </li>
       )
   }
});

var DiseaseMenu = React.createClass({
    getInitialState: function(){
      return {
          addMenu: true,
          deleteMenu: true
      }
    },
    // show/hide add Disease form
    toggleAddDisease: function(){
        this.setState({addMenu: !this.state.addMenu})
        this.props.onFormClassChange(this.state.addMenu);
    },
    toggleTrash: function(){
        this.setState({deleteMenu: !this.state.deleteMenu});
        this.props.onToggleTrash(this.state.deleteMenu);
    },
    render: function(){
        return (
            <div className="row">
                <div className="small-12 large-12 columns">
                    <h4 className="sub-menu">
                        <i className="fa fa-plus-square" onClick={this.toggleAddDisease}></i>
                        <i className="fa fa-trash" onClick={this.toggleTrash}></i>
                    </h4>
                </div>
            </div>
        )
    }
});

var DiseaseForm = React.createClass({
    getInitialState: function(){
        return {
            diagnose:"",
            condition: false,
            treatment: false,
            otherInformation: "",
            diagnoseClass: "",
            diagnosePlaceholder: "",
        }
    },
    handleDiagnoseChange: function(e){
        this.setState({diagnose: e.target.value})
    },
    handleConditionChange: function(e){
        this.setState({condition: e.target.checked})
    },
    handleTreatmentChange: function(e){
        this.setState({treatment: e.target.checked})
    },
    handleInfoChange: function(e){
        this.setState({otherInformation: e.target.value})
    },
    addDisease: function(e){
        e.preventDefault();
        var csrf_param = this.props.form.csrf_param;
        var csrf_token = this.props.form.csrf_token;

        var diagnose = this.state.diagnose.trim();
        var condition = this.state.condition;
        var treatment = this.state.treatment;
        var otherInformation = this.state.otherInformation.trim();

        if (!diagnose){
            this.setState({diagnoseClass: 'error-input-field'});
            this.setState({diagnosePlaceholder: 'this field cant be blank'});
            return;
        }

        this.props.onDiseaseSubmit({
            csrf_param: csrf_param,
            csrf_token: csrf_token,
            diagnose: diagnose,
            condition:condition,
            treatment:treatment,
            otherInformation: otherInformation
        });

        this.setState({diagnose:""});
        this.setState({condition:false});
        this.setState({treatment:false});
        this.setState({otherInformation:""});
        this.setState({diagnoseClass: ""});
        this.setState({diagnosePlaceholder: ""});
    },

    render: function(){
       return (
           <form onSubmit={this.addDisease} method="post" className={this.props.formClass} acceptCharset="UTF-8" >
               <input name="utf8" type="hidden" value="✓" />
               <input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } />

               <div className="row collapse">
                   <div className="small-4 large-4 columns">
                       <span className="prefix">Disease</span>
                   </div>
                   <div className="small-8 large-8 columns">
                       <input type="text" value={this.state.diagnose} onChange={this.handleDiagnoseChange} className={this.state.diagnoseClass}
                       placeholder={this.state.diagnosePlaceholder}/>
                   </div>
               </div>

               <div className="row">
                   <div className="small-6 large-6 columns">
                       Active issue?
                       <div className="switch round">
                           <input id="conditionCheckBox" type="checkbox"
                                  checked={this.state.condition}
                                  onClick={this.handleConditionChange}/>
                           <label htmlFor="conditionCheckBox">
                               <span className="switch-on">Yes</span>
                               <span className="switch-off">No</span>
                           </label>
                       </div>
                   </div>
                   <div className="small-6 large-6 columns">
                       Taking a treatment?
                       <div className="switch round">
                           <input id="treatmentCheckBox" type="checkbox"
                                  checked={this.state.treatment}
                                  onClick={this.handleTreatmentChange}/>
                           <label htmlFor="treatmentCheckBox">
                               <span className="switch-on">Yes</span>
                               <span className="switch-off">No</span>
                           </label>
                       </div>
                   </div>
               </div>

               <div className="row">
                   <div className="large-12 columns">
                       <label>Other Information
                           <textarea onChange={this.handleInfoChange}
                                     value={this.state.otherInformation} />
                       </label>
                   </div>
               </div>

               <div className="row">
                   <div className="small-12 large-12 columns">
                       <input type="submit" className="button tiny add" value="Add"/>
                   </div>
               </div>

           </form>
           )
   }
});