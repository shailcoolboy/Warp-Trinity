%Bug fix for Simulink scopes running out of resources
allScopes = findall(0, 'Type', 'Figure', 'Tag', 'SIMULINK_SIMSCOPE_FIGURE');
set(allScopes, 'Render', 'painters');
warning('off', 'Simulink:SL_ScopeRendererNotZBuffer');
