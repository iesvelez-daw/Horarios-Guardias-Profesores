
CREATE TABLE `Ausencias` (
  `fecha` date NOT NULL,
  `hora` int(1) NOT NULL DEFAULT '1',
  `idProfesor` char(6) NOT NULL,
  `observaciones` text 
);

--
-- Volcado de datos para la tabla `Ausencias`
--

INSERT INTO `Ausencias` (`fecha`, `hora`, `idProfesor`, `observaciones`) VALUES
('2019-01-20', 2, 'IN-2', 'Jefe de estudios'),
('2019-01-20', 3, 'IN-2', 'Jefe de estudios'),
('2019-01-20', 3, 'MA-2', ''),
('2019-01-20', 3, 'PI-1', ''),
('2019-01-20', 4, 'FQ-2', ''),
('2019-01-20', 4, 'IN-1', ''),
('2019-01-20', 4, 'IN-2', 'Jefe de estudios'),
('2019-01-20', 4, 'MA-1', ''),
('2019-01-20', 4, 'MA-2', ''),
('2019-01-20', 4, 'PI-1', ''),
('2019-01-20', 5, 'IN-2', 'Jefe de estudios'),
('2019-01-20', 5, 'PI-1', ''),
('2019-01-20', 6, 'IN-2', 'Jefe de estudios'),
('2019-01-20', 6, 'PI-1', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Grupos`
--

CREATE TABLE `Grupos` (
  `grupo` char(6)  NOT NULL,
  `nivel` varchar(20)  NOT NULL,
  `curso` char(10)  NOT NULL,
  `unidad` char(1)  NOT NULL
) ;

--
-- Volcado de datos para la tabla `Grupos`
--

INSERT INTO `Grupos` (`grupo`, `nivel`, `curso`, `unidad`) VALUES
('BACH1A', 'BACHILLERARTO', '1', 'A'),
('DAW1A', 'DAW', '1', 'A'),
('DAW2A', 'DAW', '2', 'A'),
('ESO1A', 'ESO', '1', 'A'),
('ESO1B', 'ESO', '1', 'B'),
('ESO3B', 'ESO', '3', 'B'),
('ESO4A', 'ESO', '4', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HorariosProfesores`
--

CREATE TABLE `HorariosProfesores` (
  `idProfesor` char(6)  NOT NULL,
  `periodo` varchar(50)  NOT NULL,
  `dia` char(3)  NOT NULL,
  `hora` int(11) NOT NULL,
  `grupo` char(6)  NOT NULL DEFAULT '',
  `materia` varchar(50)  NOT NULL,
  `observaciones` text  NOT NULL
) ;

--
-- Volcado de datos para la tabla `HorariosProfesores`
--

INSERT INTO `HorariosProfesores` (`idProfesor`, `periodo`, `dia`, `hora`, `grupo`, `materia`, `observaciones`) VALUES
('IN-1', '01-09-2018 a 30-06-2019', 'Mon', 4, 'DAW2A', 'Diseño de Interfaces Web', ''),
('IN-2', '01-09-2018 a 30-06-2019', 'Mon', 2, 'DAW1A', 'Bases de Datos', ''),
('IN-2', '01-09-2018 a 30-06-2019', 'Mon', 3, 'DAW1A', 'Bases de Datos', ''),
('IN-2', '01-09-2018 a 30-06-2019', 'Mon', 4, 'ESO1A', 'Tutoría', ''),
('IN-2', '01-09-2018 a 30-06-2019', 'Mon', 5, 'BACH1A', 'TIC', ''),
('PI-1', '01-09-2018 a 30-06-2019', 'Mon', 3, 'ESO1A', 'Tecnología', ''),
('PI-1', '01-09-2018 a 30-06-2019', 'Mon', 4, 'ESO1A', 'Tecnología', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Periodos`
--

CREATE TABLE `Periodos` (
  `periodo` varchar(50)  NOT NULL
) ;

--
-- Volcado de datos para la tabla `Periodos`
--

INSERT INTO `Periodos` (`periodo`) VALUES
('01-09-2018 a 30-06-2019'),
('15-03-2019 a 30-06-2019');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Profesores`
--

CREATE TABLE `Profesores` (
  `idProfesor` char(6)  NOT NULL,
  `nombreProfesor` varchar(50)  NOT NULL,
  `especialidadProfesor` varchar(50)  NOT NULL,
  `DptoProfesor` varchar(25)  NOT NULL
) ;

--
-- Volcado de datos para la tabla `Profesores`
--

INSERT INTO `Profesores` (`idProfesor`, `nombreProfesor`, `especialidadProfesor`, `DptoProfesor`) VALUES
('FQ-1', 'Francisco Martínez Vijuesca', 'PES Física y Química', 'Física y Química'),
('FQ-2', 'Encarna Sánchez', 'PES Física y Química', 'Física y Química'),
('IN-1', 'Juan Farfán Espuny', 'PES Informática', 'Informática'),
('IN-2', 'Antonio José Negro Lozano', 'PES Informática', 'Informática'),
('MA-1', 'Miriam Alcantarilla Rodríguez', 'PES Matemáticas', 'Matemáticas'),
('MA-2', 'Carmen Porras', 'PES Matemáticas', 'Matemáticas'),
('PI-1', 'José Manuel Toledo Martínez', 'PTFP Informática', 'Informática'),
('PI-2', 'Francisco Eduardo Martín Martín', 'PTFP Informática', 'Informática');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vAusencias`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vAusencias` (
`diaSemana` varchar(32)
,`hora` int(1)
,`idProfesor` char(6)
,`nombreProfesor` varchar(50)
,`grupo` char(6)
,`materia` varchar(50)
,`observaciones` text
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vAusencias`
--
DROP TABLE IF EXISTS `vAusencias`;

CREATE VIEW `vAusencias`  AS  select date_format(`a`.`fecha`,'%a') AS `diaSemana`,`a`.`hora` AS `hora`,`a`.`idProfesor` AS `idProfesor`,`p`.`nombreProfesor` AS `nombreProfesor`,`h`.`grupo` AS `grupo`,`h`.`materia` AS `materia`,`a`.`observaciones` AS `observaciones` from ((`Ausencias` `a` join `Profesores` `p` on((`a`.`idProfesor` = `p`.`idProfesor`))) left join `HorariosProfesores` `h` on(((`p`.`idProfesor` = `h`.`idProfesor`) and (date_format(`a`.`fecha`,'%a') = `h`.`dia`)))) order by 1,2,3 ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Ausencias`
--
ALTER TABLE `Ausencias`
  ADD PRIMARY KEY (`fecha`,`hora`,`idProfesor`),
  ADD KEY `idProfesor` (`idProfesor`);

--
-- Indices de la tabla `Grupos`
--
ALTER TABLE `Grupos`
  ADD PRIMARY KEY (`grupo`);

--
-- Indices de la tabla `HorariosProfesores`
--
ALTER TABLE `HorariosProfesores`
  ADD PRIMARY KEY (`idProfesor`,`periodo`,`dia`,`hora`,`grupo`),
  ADD KEY `periodo` (`periodo`),
  ADD KEY `grupo` (`grupo`);

--
-- Indices de la tabla `Periodos`
--
ALTER TABLE `Periodos`
  ADD PRIMARY KEY (`periodo`);

--
-- Indices de la tabla `Profesores`
--
ALTER TABLE `Profesores`
  ADD PRIMARY KEY (`idProfesor`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Ausencias`
--
ALTER TABLE `Ausencias`
  ADD CONSTRAINT `Ausencias_ibfk_1` FOREIGN KEY (`idProfesor`) REFERENCES `Profesores` (`idProfesor`);

--
-- Filtros para la tabla `HorariosProfesores`
--
ALTER TABLE `HorariosProfesores`
  ADD CONSTRAINT `HorariosProfesores_ibfk_1` FOREIGN KEY (`idProfesor`) REFERENCES `Profesores` (`idProfesor`),
  ADD CONSTRAINT `HorariosProfesores_ibfk_2` FOREIGN KEY (`periodo`) REFERENCES `Periodos` (`periodo`),
  ADD CONSTRAINT `HorariosProfesores_ibfk_3` FOREIGN KEY (`grupo`) REFERENCES `Grupos` (`grupo`);
