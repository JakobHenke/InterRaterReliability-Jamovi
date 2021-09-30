
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"CID","title":"Rater ID","type":"Variable","suggested":["nominal","id"],"permitted":["factor","id"]},{"name":"CaID","title":"Case ID","type":"Variable","suggested":["nominal","id"],"permitted":["factor","id"]},{"name":"vals","title":"Values","type":"Variables"},{"name":"percAgree","title":"Simple percent agreement","type":"Bool","default":false},{"name":"hol","title":"Holsti's coefficient","type":"Bool","default":false},{"name":"naMethod","title":"Method","type":"List","options":[{"name":"pairwise","title":"Exclude cases analysis by analysis"},{"name":"listwise","title":"Exclude cases listwise"}],"default":"pairwise"},{"name":"rat","title":"Raters","type":"Bool","default":false},{"name":"cas","title":"Cases","type":"Bool","default":false}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "percent Agreement",
    jus: "3.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.VariableSupplier,
			typeName: 'VariableSupplier',
			persistentItems: false,
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Rater ID",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "CID",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Case ID",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "CaID",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Values",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "vals",
							isTarget: true
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Analyses"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "percAgree"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "hol"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Missing Values"
				},
				{
					type: DefaultControls.LayoutBox,
					typeName: 'LayoutBox',
					margin: "large",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "naMethod_pair",
							optionName: "naMethod",
							optionPart: "pairwise"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "naMethod_list",
							optionName: "naMethod",
							optionPart: "listwise"
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Additional Information"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "rat"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "cas"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
