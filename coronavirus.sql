CREATE TABLE `coronavirus` (
  `identifier` varchar(180) NOT NULL,
  `havecorona` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

ALTER TABLE `coronavirus`
  ADD PRIMARY KEY (`identifier`),
  ADD KEY `identifier` (`identifier`);

