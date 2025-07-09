Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9023FC41
	for <netfs@lists.linux.dev>; Wed,  9 Jul 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097457; cv=none; b=nmCZUOF27O/y7aJyCwn5yTA5VlO98JBgjgxpHQdgbZuhF9wWrcofL/jkra80emHkb6xXbBC2IlWpkYff1qEnBG06JPySEHk3OnhH425fxy4KOpDsRwupDQo+J35wA2rCV26uwBqwm5tGt6YKOH4LxU+fTcei8ECpfJDiGcTsvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097457; c=relaxed/simple;
	bh=QM3ZwKzZ3tmooQKRsyzdW8dMI+e0bgrGReSxQbsBbz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhxf74pud0eo8E+W1LTwvAqhKAf+NVi3iKyR9aUidPGr5o2V6nnbRqS9DVvWLxoGhBYTY/zA21OUSfoLHlfT2rpSUymHJCQgF7O3zTht5bjD98gS3MsQwVsh/k9PmXlaBUXEClD4QeTUnm2l+FopTYgg1ytRrZTXK/tjG3sHSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ILyDl3dz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ILyDl3dz"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae35f36da9dso55666966b.0
        for <netfs@lists.linux.dev>; Wed, 09 Jul 2025 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752097453; x=1752702253; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=ILyDl3dzPMOqlzdIkgxt/dxBsMDLiIAoCPM/9FKnh2S5HZoNarauB0OMPJ2PGCxB3H
         DBSFidcZxNyNGY8u0RpfdXOi4mN10qdolntJ+ROL4B8KcUNQRqp6QtIHq3SSWx1QcHev
         5XZv1+kUpwUJ1YM950gZTXq7Tne6MAWtELlevAeeT/w3tBePdk6IdrJuzIFxf2P9/apt
         lz/Fbu5/7gxE43rQMZgmlIGxrzLYRad6vhQ7DecLidiXLKGKlnDhDTLtRgavB6x8B6Hw
         hkRghWqcZ8cw1zdz5oooiYgppeGnYguyGc2lg/9k7FXlnTHtfPJ9MzwofZKSyVVXc1CS
         14Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097453; x=1752702253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=OHEmXazUfdGcLsF3AW4c06IbKlpR6vqXIfu4m9/3eFmNVPhQRSBqH0SXIzp0TaEu85
         HhhSI3eL9W3sQ4swhYP9eOGdPeEQeoW+DHwCAj8nJECsVIED4f4eXoNQhIEfy0Ndp1Hz
         xgmEygCu5tgetEeAyuvQJdDyjg6Gth5UGPLjF94RI7/YAsdSsCGAj+w1CPPU1LSxCghI
         y7G1NmWhuF1O9titQpQPwiFs+SHgdkf68rWbtdEHv/fQdYjZzAALqUQE9cWqFEvkCeL/
         lgsBqbA77IQDi4HUEt/iwsc5jXpMKmIxl47dFDyodtulV7JtHq/ZSBv3sY7KZVYQ4hYN
         IN7A==
X-Forwarded-Encrypted: i=1; AJvYcCVKjqla3T9YvZIKBMt16TKMabwJwvImD2M8hfKCF1P8myd7T9aRgnWuff1PdPHTNMKU2UOfaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZyxmhV2yQ8Yy91GkqEl9LbazMlR4NDgY959PIUYEY/YeuRrbN
	O6g2FlP4byjuqstXIzrg9164BxD2D//DeBUil1gp+EZ8r9oOPio4JNMQ7Evy8wPFiM5fxTSQzt7
	/oj7jLyWlZPTC1GcDuq3i+LLU6XOiR6QnVdvblijxR2ssm5rcXzB2
X-Gm-Gg: ASbGncu2ikkQbQ5L/vvtvF4+t4KARKwwLDq38chlLxEU92oe8bpxuONgJ97YRrmRJiw
	MoNzABcmYyYfGvPVj2vGIZa2bSX+dcJAR6nBZoKYE7ewfz3qhQGGFOHi6eWRWMGIXQYrkiJio3F
	DWRGweAMrpNgGzVCXXT/7bpnR6qb/5k1OgBdF+3GUKYZBH4GeH2AYT30LbzUIh/szeX7h27pA=
X-Google-Smtp-Source: AGHT+IHRfBgI+JpvIFW5bdEhu8EMbBsinsmaICn0S2xVCrLK7zPglEC6AbVpvLywHBFg/8fSMjerPI4gbWHSZhnMN/4=
X-Received: by 2002:a17:906:46d9:b0:ae3:d1fe:f953 with SMTP id
 a640c23a62f3a-ae6e7099e16mr25848366b.43.1752097453229; Wed, 09 Jul 2025
 14:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
 <2738562.1752092552@warthog.procyon.org.uk>
In-Reply-To: <2738562.1752092552@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 23:44:02 +0200
X-Gm-Features: Ac12FXwGyOaYIBhD6kJLi5Rdp0KMSI4jWTqWW8bY_UVcRj5P-WQCdanG6BjA4Q0
Message-ID: <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 10:22=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> > (The above was 6.15.5 plus all patches in this PR.)
>
> Can you check that, please?  If you have patch 12 applied, then the flags
> should be renumbered and there shouldn't be a NETFS_RREQ_ flag with 13, b=
ut
> f=3D80002020 would seem to have 0x2000 (ie. bit 13) set in it.

Oh, I was slightly wrong, I merged only 12 patches, omitting the
renumbering patch because it had conflicts with my branch, and it was
only a cosmetic change, not relevant for the bug. Sorry for the
confusion!
