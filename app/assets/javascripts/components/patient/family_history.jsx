
var FamilyHistoryBox = React.createClass({

    getInitialState: function(){
        return {
            familyHistories: [],
            form: [],
            formClass: 'hide',
            trashClass: 'hide'
        }
    },
    componentDidMount: function(){
        $.ajax({
            url: this.props.url_get+"?id="+this.props.patient_id,
            dataType: 'json',
            success: function(data){
                this.setState({familyHistories: data.familyHistories});
                this.setState({form: data.form});
            }.bind(this),
            error: function(xhr, status, err){
                //console.error(this.props.url_get, status, err.toString());
            }.bind(this)
        });
    },
    render: function() {
        return (
            <div className="familyHistory">
                <FamiliyHistoryList familyHistories={this.state.familyHistories} />
                <FamiliyHistoryForm form={this.state.form} />
            </div>
        )
    }
});

var FamiliyHistoryList = React.createClass({
    render: function(){
        var familyHistories = this.props.familyHistories.map(function(familyHistory){
           return  <FamilyHistoryBox familyHistoryObj={familyHistory} key={familyHistory.key} />
        });
        return (
            <ul>
                {familyHistories}
            </ul>
        )
    }
});

var FamilyHistory = React.createClass({
   render: function(){
       return (
           <li>
               {this.props.familyHistory.age}
           </li>
       )
   }
});
var FamilyHistoryMenu = React.createClass({
   render: function(){
       return (
           <p>menu</p>
       )
   }
});

var FamiliyHistoryForm = React.createClass({
    getInitialState: function(){
        return {
            alive: false,
            age: 0,
            relationship: 'alive',
            otherInformation: ''
        }
    },
    addFamilyHistory: function(e){
      e.preventDefault();

    },
    render: function(){
        return (
            <form onSubmit={this.addFamilyHistory} method="post" accept-charset="utf-8" >
                <input name="utf8" type="hidden" value="✓" />
                <input type="hidden" name={ this.props.form.csrf_param} value={ this.props.form.csrf_token } />

                <div className="row">
                    <div className="large-12 columns">
                        <select name="alive" value={this.state.relationship}>
                            <option value="alive">Alive</option>
                            <option value="deceased">Deceased</option>
                        </select>
                    </div>
                </div>

                <div className="row">
                    <div className="large-12 columns">

                        <div className="row collapse">
                            <div className="small-4 large-4 columns">
                                <span className="prefix">Age</span>
                            </div>
                            <div className="small-8 large-8 columns">
                                <input type="text" value={this.state.age} />
                            </div>
                        </div>

                    </div>
                </div>

                <div className="row">
                    <div className="large-12 columns">

                        <div className="row collapse">
                            <div className="small-7 large-5 columns">
                                <span className="prefix">Other Information</span>
                            </div>
                            <div className="small-5 large-7 columns">
                                <input type="text" value={this.state.otherInformation} />
                            </div>
                        </div>

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